$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'hss/version'

Gem::Specification.new do |s|
  s.name        = 'hss'
  s.version     = HSS::VERSION
  s.required_ruby_version = '>= 2.6'

  s.summary     = 'SSH helper'
  s.description = 'Regex-based SSH shortcut tool'
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/hss'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.executables = ['hss']

  s.add_development_dependency 'fuubar', '~> 2.5.0'
  s.add_development_dependency 'goodcop', '~> 0.9.0'
  s.add_development_dependency 'rake', '~> 13.0.0'
  s.add_development_dependency 'rspec', '~> 3.11.0'
  s.add_development_dependency 'rubocop', '~> 1.35.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
