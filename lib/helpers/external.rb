require 'yaml'

##
# Load values from an external YAML hash

class HSS::Parser
  private

  def external(source, key)
    begin
      config = open(File.expand_path(source)) { |f| YAML.load f.read }
    rescue Psych::SyntaxError, Errno::ENOENT
      raise "Failed to open YAML file: #{source}"
    end
    begin
      key.split('.').reduce(config) { |a, e| a[e] } || fail
    rescue
      raise NameError, "Key not found in YAML: #{key}"
    end
  end
end
