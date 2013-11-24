require 'spec_helper'

describe HSS do
  let(:config) { 'spec/test/config.yml' }
  let(:handler) { HSS::Handler.new config }

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
      let(:invalid) { 'spec/test/invalid.yml' }
      let(:incomplete) { 'spec/test/incomplete.yml' }

      it 'loads the specified YAML file' do
        expect(handler.config).to be_an_instance_of Hash
        expect(handler.patterns).to be_an_instance_of Array
      end
      it 'raises an error for invalid configs' do
        expect { HSS::Handler.new invalid }.to raise_error RuntimeError
      end
      it 'raises an error for configs without patterns' do
        expect { HSS::Handler.new incomplete }.to raise_error RuntimeError
      end
      it 'raises an error if the config does not exist' do
        expect { HSS::Handler.new 'foobaz' }.to raise_error RuntimeError
      end
      it 'uses the default config if none is provided' do
        if File.exists? File.expand_path(HSS::DEFAULT_CONFIG)
          expect(HSS::Handler.new.config).to be_an_instance_of Hash
        else
          expect { HSS::Handler.new }.to raise_error RuntimeError
        end
      end
    end

    describe '#load_helpers' do
      it 'loads helper modules' do
        expect(handler.helpers).to be_an_instance_of Array
        expect(handler.helpers).to have_at_least(3).items
      end
      it 'accepts a helper_path' do
        h = HSS::Handler.new(config: config, helpers: 'spec/test/good_helpers')
        expect(h.helpers).to be_an_instance_of Array
        expect(h.helpers.size).to eql 2
      end
      it 'raises LoadError if loading modules fails' do
        options = { config: config, helpers: 'spec/test/bad_helpers' }
        expect { HSS::Handler.new options }.to raise_error LoadError
      end
    end
  end
end
