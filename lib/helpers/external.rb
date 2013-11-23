class HSS::Parser
  def external(cmd)
    IO.popen(cmd).read
  end
end
