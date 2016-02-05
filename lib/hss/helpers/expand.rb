module HSS
  ##
  # Expand a shortcode based the config hash
  class Parser
    private

    def expand(input)
      @config['expansions'].each do |long, shorts|
        return long if shorts.include? input
      end
      raise NameError, "No expansion found for: #{input}"
    end
  end
end
