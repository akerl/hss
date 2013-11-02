require 'yaml'
require 'pathname'
require 'erb'

module HSS
    Version = '0.2.0'
    Default_Config = '~/.hss.yml'
    Default_Library = Pathname.new(__FILE__).realpath.split()[0].to_s + '/helpers'

    class << self
        def new(*args)
            HSS::Handler.new(*args)
        end
    end

    class Handler
        attr_reader :patterns, :config

        def initialize(config_path = nil, helper_path = nil)
            load_config(config_path)
            load_parser(helper_path)
        end

        def load_config(config_path = nil)
            begin
                @config = YAML.load open(File.expand_path(config_path || HSS::Default_Config)).read
                @patterns = @config.delete('patterns')
            rescue
                raise "Failed to load config: #{config_path}"
            end
        end

        def load_parser(helper_path = nil)
            Dir::glob((helper_path || HSS::Default_Library) + '/*').each do |helper|
                begin
                    require_relative helper
                rescue LoadError
                    raise LoadError, "Failed to load helper: #{helper}"
                end
            end
            @parser = HSS::Parser.new(@config)
        end

        def handle(input)
            @patterns.each do |pattern|
                next unless @parser.check(input, pattern['short'])
                return @parser.parse(pattern['long'])
            end
            raise "Couldn't find a matching host for: #{input}"
        end

        def woof()
            puts "bark"
        end
    end

    class Parser
        def initialize(config)
            @config = config
        end

        def check(input, short_form)
            return false unless input.match short_form
            @match_data = binding
            true
        end
        def parse(long_form)
            eval '"' +  long_form + '"', @match_data
        end
    end
end
