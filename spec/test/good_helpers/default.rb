##
# Provides a helper to have default values
module HSS
  class Parser
    def default(a, b)
      a.nil? || a.empty? ? b : a
    end
  end
end
