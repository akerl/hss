##
# Allow shortcut expansion from the config
module HSS
  class Parser
    def shortcut(input)
      @config['shortcuts'][input]
    end
  end
end
