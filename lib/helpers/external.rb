require 'yaml'

##
# Load values from an external YAML hash

class HSS::Parser
  def external(source, key)
    config = open(File.expand_path(source)) { |f| YAML.load f.read }
    key.split('.').reduce(nil) { |a, e| config[e] }
  end
end
