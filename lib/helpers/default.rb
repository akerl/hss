class HSS::Parser
    def default(a, b)
        (a.nil? or a.empty?) ? b : a
    end
end

