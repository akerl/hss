##
# Allow shortcut expansion from the config

class HSS::Parser
  def shortcut(input)
    @config['shortcuts'][input]
  end
end
