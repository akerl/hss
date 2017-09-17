module HSS
  ##
  # Allow shortcut expansion from the config
  class Parser
    private

    def shortcut(input)
      @config.dig('shortcuts', input) || raise(NameError, "Shortcut does not exist #{input}") # rubocop:disable Metrics/LineLength
    end
  end
end

unless {}.respond_to? :dig
  ##
  # Define dig method if it didn't exist (because Ruby predates 2.3)
  class Hash
    def dig(arg, *args)
      self[arg] ? self[arg].dig(args) : nil
    end
  end
end
