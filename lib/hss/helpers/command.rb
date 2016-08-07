require 'English'

module HSS
  ##
  # Runs a shell command and returns the output
  class Parser
    private

    def command(input)
      result = IO.popen(input) { |cmd| cmd.read.chomp }
      raise("Command failed: #{input}") unless $CHILD_STATUS.exitstatus.zero?
      result
    rescue Errno::ENOENT
      raise "Command not found: #{input}"
    end
  end
end
