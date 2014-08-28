module HSS
  ##
  # Allow shortcut expansion from the config
  class Parser
    private

    def shortcut(input)
      @config['shortcuts'][input] || fail
    rescue
      raise NameError, "Shortcut does not exist #{input}"
    end
  end
end
