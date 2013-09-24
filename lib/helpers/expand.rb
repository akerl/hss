class HSS::Parser
    def expand(input)
        @config['expansions'].each { |long, shorts| return long if shorts.include? input }
        raise NameError, "No expansion found for: #{input}"
    end
end

