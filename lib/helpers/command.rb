class HSS::Parser
    def command(input)
        return IO.popen(input) { |cmd| cmd.read }
    end
end

