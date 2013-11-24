##
# Allow shortcut expansion from the config

class HSS::Parser
  def shortcut(input)
    @config['shortcuts'][input] || fail
  rescue
    raise NameError, "Shortcut does not exist #{input}"
  end
end
