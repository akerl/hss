module HSS
  ##
  # Provides a helper to have default values
  class Parser
    private

    def default(a, b)
      a.nil? || a.empty? ? b : a
    end
  end
end
