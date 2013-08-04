#!/usr/bin/env ruby

require 'yaml'
require 'pathname'

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

Config = open(Pathname.new(__FILE__).realpath.split()[0].to_s + '/config.yml') { |file| YAML.load(file.read) }
Input = ARGV.pop
Args = ARGV.join(' ')

if Input == 'help'
    puts 'How to use:'
    puts '(what you type) -> (where it takes you)'
    Config['patterns'].each { |pattern| puts pattern['example'] }
else
    Config['patterns'].each do |pattern|
        next unless Input.match(pattern['short'])
        long_form = eval '"' + pattern['long'] + '"'
        exec "ssh #{Args} #{long_form}"
    end
end

