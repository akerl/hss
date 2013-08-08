#!/usr/bin/env ruby

require 'yaml'
require 'pathname'
require 'erb'

def expand(input)
    Config['expansions'].each { |long, shorts| return long if shorts.include? input }
    raise NameError, "No expansion found for: #{input}"
end

def shortcut(input)
    return Config['shortcuts'][input]
end

def command(input)
    return IO.popen(input) { |cmd| cmd.read }
end

possible_paths = [
    File.expand_path(ENV['HSS_CONFIG'].to_s),
    File.expand_path('~/.hss.yml'),
    Pathname.new(__FILE__).realpath.split()[0].to_s + '/config.yml',
]
possible_paths = possible_paths.select { |path| not File.directory? path and File.exists? path }
if possible_paths.empty?
    puts 'No config file found'
    exit 1
end

Config = open(possible_paths[0]) { |file| YAML.load(file.read) }
Input = ARGV.pop
Args = ARGV.join(' ')

if Input.nil? or Input == 'help'
    puts 'How to use:'
    puts '(what you type) -> (where it takes you)'
    Config['patterns'].each { |pattern| puts pattern['example'] }
else
    Config['patterns'].each do |pattern|
        next unless Input.match(pattern['short'])
        long_form = ERB.new('<%= "' + pattern['long'] + '" %>').result
        exec "ssh #{Args} #{long_form}"
    end
end

puts "Couldn't find a matching host for: #{Input}"
exit 1

