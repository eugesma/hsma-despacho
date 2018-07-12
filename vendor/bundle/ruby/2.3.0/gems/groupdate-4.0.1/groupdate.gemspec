# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "groupdate/version"

Gem::Specification.new do |spec|
  spec.name          = "groupdate"
  spec.version       = Groupdate::VERSION
  spec.authors       = ["Andrew Kane"]
  spec.email         = ["andrew@chartkick.com"]
  spec.summary       = "The simplest way to group temporal data"
  spec.homepage      = "https://github.com/ankane/groupdate"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.2.0"

  spec.add_dependency "activesupport", ">= 4.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "activerecord"

  if RUBY_PLATFORM == "java"
    spec.add_development_dependency "activerecord-jdbcpostgresql-adapter"
    spec.add_development_dependency "activerecord-jdbcmysql-adapter"
    spec.add_development_dependency "activerecord-jdbcsqlite3-adapter"
  else
    spec.add_development_dependency "pg", "< 1"
    spec.add_development_dependency "mysql2", "< 0.5"
    spec.add_development_dependency "sqlite3"
  end
end
