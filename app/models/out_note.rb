class OutNote < ApplicationRecord
  include PgSearch

  enum order_type: { nota: 0, pase: 1 }
  
  # Validaciones
  validates_presence_of :author, :reference, :origin, :destination_id, :origin_id, :out_date, :entry_date
  validates_presence_of :note_number, if: :nota?
  validates_presence_of :zonal_pass, if: :pase?
  validate :unique_note_number, if: :nota?
  validate :unique_zonal_pass, if: :pase?

  # Relaciones
  belongs_to :author, class_name: 'User'
  belongs_to :origin, class_name: 'Sector', foreign_key: 'origin_id', counter_cache: true
  belongs_to :destination, class_name: 'Sector', foreign_key: 'destination_id', counter_cache: true
  has_many_attached :files

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_text,
      :entry_date_at,
      :out_date_at,
      :search_number,
    ]
  )

  pg_search_scope :search_text,
    against: :reference,
    :associated_against => {
      :origin => :name,
      :destination => :name
    },
    :using => {
      :tsearch => {:prefix => true}
    },
    :ignoring => :accents

  pg_search_scope :search_number,
    against: [:note_number, :zonal_pass],
    :using => {
      :tsearch => {:prefix => true}
    },
    :ignoring => :accents

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/s
      # Ordenamiento por fecha de creación en la BD
      order("out_notes.created_at #{ direction }")
    when /^numero_/
      # Ordenamiento por el numero de entrada
      order("out_notes.note_number #{ direction }")
    when /^origen_/
      # Ordenamiento por nombre de origen
      order("LOWER(sectors.sector_name) #{ direction }").joins("INNER JOIN sectors ON sectors.id = out_notes.origin_id")
    when /^destino_/
      # Ordenamiento por nombre de destino
      order("LOWER(sectors.sector_name) #{ direction }").joins("INNER JOIN sectors ON sectors.id = out_notes.destination_id")
    when /^fecha_entrada_/
      # Ordenamiento por la fecha de recepción
      order("out_notes.entry_date #{ direction }")
    when /^fecha_salida_/
      # Ordenamiento por la fecha de dispensación
      order("out_notes.out_date #{ direction }")
    else
      # Si no existe la opcion de ordenamiento se levanta la excepción
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :entry_date_at, lambda { |reference_time|
    where('out_notes.entry_date >= ?', reference_time)
  }

  scope :out_date_at, lambda { |reference_time|
    where('out_notes.out_date >= ?', reference_time)
  }

  scope :with_note_number, lambda { |number|
    where('out_notes.note_number = ?', number)
  }

  # Método para establecer las opciones del select input del filtro
  # Es llamado por el controlador como parte de `initialize_filterrific`.
  def self.options_for_sorted_by
    [
      ['Creación (desc)', 'created_at_desc'],
      ['Numero (asc)', 'numero_asc'],
      ['Origen (a-z)', 'origen_asc'],
      ['Destino (a-z)', 'destino_asc'],
      ['Fecha entrada(asc)', 'fecha_entrada_asc'],
      ['Fecha salida(asc)', 'fecha_salida_asc']
    ]
  end

  private

  def unique_note_number
    if self.nota?
      range = Time.now.beginning_of_year..Time.now.end_of_year
      return unless OutNote.exists?(note_number: note_number, created_at: range)
      errors.add(:note_number, "ya existe "+note_number.to_s+" en el año "+DateTime.now.beginning_of_year.strftime("%Y"))
    end
  end

  def unique_zonal_pass
    if self.pase?
      range = Time.now.beginning_of_year..Time.now.end_of_year
      return unless OutNote.exists?(zonal_pass: zonal_pass, created_at: range)
      errors.add(:zonal_pass, "ya existe "+zonal_pass.to_s+" en el año "+DateTime.now.beginning_of_year.strftime("%Y"))
    end
  end
end
