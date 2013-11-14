class HSS::Parser
  def default(a, b)
    a.nil? || a.empty? ? b : a
  end
end

