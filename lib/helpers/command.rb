require 'English'

module HSS
  ##
  # Runs a shell command and returns the output
  class Parser
    private

    def command(input)
      result = IO.popen(input) { |cmd| cmd.read.chomp }
      fail "Command failed: #{input}" unless $CHILD_STATUS == 0
      result
    rescue Errno::ENOENT
      raise "Command not found: #{input}"
    end
  end
end
