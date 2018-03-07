require 'yaml'

module HSS
  ##
  # Load values from an external YAML hash
  class Parser
    private

    def external(source, key)
      config = File.open(File.expand_path(source)) { |f| YAML.safe_load f.read }
      key.split('.').reduce(config) { |acc, elem| acc[elem] } || raise
    rescue Psych::SyntaxError, Errno::ENOENT
      raise "Failed to open YAML file: #{source}"
    rescue StandardError
      raise NameError, "Key not found in YAML: #{key}"
    end
  end
end
