# frozen_string_literal: true

require 'yaml'
require 'pathname'
require 'hss/version'

##
# HSS module provides a helper for SSH shortcuts
module HSS
  DEFAULT_CONFIG = File.join(Dir.home, '.hss.yml')
  DEFAULT_LIB = File.join(Pathname.new(__FILE__).realpath.split[0], 'hss', 'helpers')
  CONFIG_DELIMITERS = /cygwin|mswin|mingw|bccwin|wince|emx/.match?(RUBY_PLATFORM) ? ';' : /[:;]/

  class << self
    ##
    # Insert a helper .new() method for creating a new Cache object

    def new(*args)
      HSS::Handler.new(*args)
    end
  end

  ##
  # Handlers load configurations and control their use
  class Handler
    attr_reader :patterns, :config, :helpers

    ## Make a new handler with a config and parser

    def initialize(params = {})
      params = { config: params } if params.is_a? String
      load_config(params[:config])
      @helpers = []
      load_helpers(params[:helpers])
      @parser = HSS::Parser.new(@config)
    end

    ##
    # Check patterns for a match and parse the long form

    def handle(input)
      @patterns.each do |pattern|
        next unless @parser.check(input, pattern['short'])
        return @parser.parse(pattern['long'])
      end
      raise NameError, "Couldn't find a matching host for: #{input}"
    end

    private

    ##
    # Load the config file

    def load_config(config_path = nil)
      path = File.expand_path(config_path || HSS::DEFAULT_CONFIG)
      files = path.split(CONFIG_DELIMITERS).map { |x| YAML.safe_load File.read x }
      @config = files.reverse.reduce(&:deep_merge)
      @patterns = @config.delete('patterns') || raise
    # rubocop:disable Lint/ShadowedException
    rescue Psych::SyntaxError, RuntimeError, Errno::ENOENT
      raise "Failed to load config: #{config_path}"
    end
    # rubocop:enable Lint/ShadowedException

    ##
    # Load helper modules

    def load_helpers(helper_path = nil)
      helper_path ||= HSS::DEFAULT_LIB
      helper_path = File.expand_path(helper_path)
      Dir.glob(File.join(helper_path, '*')).sort.each do |helper|
        require helper
        @helpers << helper
      rescue LoadError, SyntaxError
        raise LoadError, "Failed to load helper: #{helper}"
      end
    end
  end

  ##
  # Parser objects exist as containers for helper methods
  class Parser
    ##
    # The config is scoped here so it is available to helpers

    def initialize(config)
      @config = config
    end

    ##
    # Check for a match
    # If the input matches, store the context for use in helpers

    def check(input, short_form)
      return false unless input.match short_form
      x = Regexp.last_match
      @match_data = binding
      true
    end

    ##
    # Evaluate the long_form using the stored context

    def parse(long_form)
      a = eval "%Q{#{long_form}}", @match_data, __FILE__, __LINE__ # rubocop:disable Security/Eval
      a == long_form ? a : parse(a)
    end
  end
end

##
# Time to monkeypatch Hash to support smarter merging
class Hash
  ##
  # Define a method to merge config hashes

  def deep_merge(new)
    merge(new) do |_, oldval, newval|
      case oldval
      when Hash
        deep_merge oldval, newval
      when Array
        oldval + newval
      else
        newval
      end
    end
  end
end
