require "tempfile"

module ImageProcessing
  class Pipeline
    DEFAULT_FORMAT = "jpg"

    attr_reader :source, :loader, :saver, :format, :operations, :processor, :destination

    def initialize(options)
      options.each do |name, value|
        value = normalize_source(value, options) if name == :source
        instance_variable_set(:"@#{name}", value)
      end
    end

    def call(save: true)
      accumulator = processor.load_image(source, **loader)

      operations.each do |name, args, block|
        accumulator = processor.apply_operation(accumulator, name, *args, &block)
      end

      if save == false
        accumulator
      elsif destination
        handle_destination do
          processor.save_image(accumulator, destination, **saver)
        end
      else
        create_tempfile do |tempfile|
          processor.save_image(accumulator, tempfile.path, **saver)
        end
      end
    end

    def source_path
      source if source.is_a?(String)
    end

    def destination_format
      format   = File.extname(destination)[1..-1] if destination
      format ||= self.format
      format ||= File.extname(source_path)[1..-1] if source_path

      format || DEFAULT_FORMAT
    end

    private

    def create_tempfile
      tempfile = Tempfile.new(["image_processing", ".#{destination_format}"], binmode: true)

      yield tempfile

      tempfile.open
      tempfile
    rescue
      tempfile.close! if tempfile
      raise
    end

    # In case of processing errors, both libvips and imagemagick will leave the
    # empty destination file they created, so this method makes sure it is
    # deleted in case an exception is raised on saving the image.
    def handle_destination
      destination_existed = File.exist?(destination)
      yield
    rescue
      File.delete(destination) if File.exist?(destination) && !destination_existed
      raise
    end

    def normalize_source(source, options)
      fail Error, "source file is not provided" unless source

      accumulator_class = options[:processor]::ACCUMULATOR_CLASS

      if source.is_a?(accumulator_class)
        source
      elsif source.is_a?(String)
        source
      elsif source.respond_to?(:path)
        source.path
      elsif source.respond_to?(:to_path)
        source.to_path
      else
        fail Error, "source file needs to respond to #path, or be a String, a Pathname, or a #{accumulator_class} object"
      end
    end
  end
end
