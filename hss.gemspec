$:.unshift File.expand_path('../lib/', __FILE__)
require 'hss.rb'

Gem::Specification.new do |s|
  s.name        = 'hss'
  s.version     = HSS::VERSION
  s.date        = Time.now.strftime("%Y-%m-%d") 
  s.summary     = 'SSH helper'
  s.description = 'Regex-based SSH shortcut tool'
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split
  s.executables = ['hss']
  s.homepage    = 'https://github.com/akerl/hss'
  s.license     = 'MIT'

  %w(rubocop travis-lint rake coveralls rspec fuubar).each do |gem|
    s.add_development_dependency gem
  end
  s.add_development_dependency 'parser', '~> 2.1.0.pre1'
end

