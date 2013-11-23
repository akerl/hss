##
# Runs a shell command and returns the output

class HSS::Parser
  def command(input)
    IO.popen(input) { |cmd| cmd.read }
  end
end
