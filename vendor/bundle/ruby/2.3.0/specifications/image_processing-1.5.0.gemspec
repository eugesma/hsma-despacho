# -*- encoding: utf-8 -*-
# stub: image_processing 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "image_processing".freeze
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Janko Marohni\u{107}".freeze]
  s.date = "2018-07-09"
  s.description = "Set of higher-level helper methods for image processing.".freeze
  s.email = ["janko.marohnic@gmail.com".freeze]
  s.homepage = "https://github.com/janko-m/image_processing".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0".freeze)
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Set of higher-level helper methods for image processing.".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mini_magick>.freeze, ["~> 4.0"])
      s.add_runtime_dependency(%q<ruby-vips>.freeze, ["< 3", ">= 2.0.11"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.8"])
      s.add_development_dependency(%q<minitest-hooks>.freeze, [">= 1.4.2"])
      s.add_development_dependency(%q<minispec-metadata>.freeze, [">= 0"])
      s.add_development_dependency(%q<phashion>.freeze, [">= 0"])
    else
      s.add_dependency(%q<mini_magick>.freeze, ["~> 4.0"])
      s.add_dependency(%q<ruby-vips>.freeze, ["< 3", ">= 2.0.11"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.8"])
      s.add_dependency(%q<minitest-hooks>.freeze, [">= 1.4.2"])
      s.add_dependency(%q<minispec-metadata>.freeze, [">= 0"])
      s.add_dependency(%q<phashion>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<mini_magick>.freeze, ["~> 4.0"])
    s.add_dependency(%q<ruby-vips>.freeze, ["< 3", ">= 2.0.11"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.8"])
    s.add_dependency(%q<minitest-hooks>.freeze, [">= 1.4.2"])
    s.add_dependency(%q<minispec-metadata>.freeze, [">= 0"])
    s.add_dependency(%q<phashion>.freeze, [">= 0"])
  end
end
