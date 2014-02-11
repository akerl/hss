##
# Provides a helper to have default values
class HSS::Parser
  def default(a, b)
    a.nil? || a.empty? ? b : a
  end
end
