# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tapir/version'

Gem::Specification.new do |gem|
  gem.name          = "tapir"
  gem.version       = Tapir::VERSION
  gem.authors       = ["Michael Tomer"]
  gem.email         = ["michaeltomer@gmail.com"]
  gem.description   = %q{Quickly create secure, searchable APIs}
  gem.summary       = %q{Tapir works with ActiveRecord to create extremely flexible APIs. It has a secure query language that lets users filter, sort, and join data while preventing them from accessing anything they shouldn't be allowed to.}
  gem.homepage      = "http://actsasbuffoon.com/tapir"

  gem.add_development_dependency 'rspec', '~> 2.12.0'
  gem.add_development_dependency 'rails-api', '0.0.2'
  gem.add_development_dependency 'rack-test', '~> 0.6.2'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
