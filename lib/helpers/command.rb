class HSS::Parser
  def command(input)
    IO.popen(input) { |cmd| cmd.read }
  end
end

