require 'spec_helper'

describe HSS do
  let(:config) { 'spec/config.yml' }
  let(:invalid) { 'spec/invalid.yml' }
  let(:handler) { HSS::Handler.new(skip_load: true) }
  describe '::VERSION' do
    it 'follows the semantic version scheme' do
      expect(HSS::VERSION).to match /\d+\.\d+\.\d+/
    end
  end

  describe '#new' do
    it 'creates Handler objects' do
      expect(HSS.new(config: config)).to be_an_instance_of HSS::Handler
    end
  end

  describe HSS::Handler do
    describe '#new' do
      it 'creates Handler objects' do
        expect(handler).to be_an_instance_of HSS::Handler
      end
    end
    describe '#load_config' do
      it 'loads the specified YAML file' do
        expect(handler.config).to be_nil
        handler.load_config config
        expect(handler.config).to be_an_instance_of Hash
        expect(handler.patterns).to be_an_instance_of Array
      end
      it 'raises an error for invalid configs' do
        expect { handler.load_config invalid }.to raise_error RuntimeError
      end
      it 'uses the default config if none is provided' do
        if File.exists? File.expand_path(HSS::DEFAULT_CONFIG)
          expect(handler.load_config).to be_an_instance_of Array
        else
          expect { handler.load_config }.to raise_error RuntimeError
        end
      end
    end
  end
end
