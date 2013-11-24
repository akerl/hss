##
# Provides a helper to have default values

class HSS::Parser
  private

  def default(a, b)
    a.nil? || a.empty? ? b : a
  end
end
