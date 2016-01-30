# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gobble/version'

Gem::Specification.new do |spec|
  spec.name          = 'gobble'
  spec.version       = Gobble::VERSION
  spec.author        = 'Bryan Enders'

  spec.summary       = 'A program that gobbles up a dictionary and spits out the remains.'

  spec.required_ruby_version = '>= 2.2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = ['gobble']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0'
end
