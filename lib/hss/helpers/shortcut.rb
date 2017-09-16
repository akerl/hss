module HSS
  ##
  # Allow shortcut expansion from the config
  class Parser
    private

    def shortcut(input)
      @config.dig('shortcuts').dig(input) || raise(NameError, "Shortcut does not exist #{input}") # rubocop:disable Metrics/LineLength
    end
  end
end
