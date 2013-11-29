require 'spec_helper'

describe HSS do
  let(:config) { 'spec/test/config.yml' }
  let(:handler) { HSS::Handler.new config }

  describe '::VERSION' do
    it 'follows the semantic version scheme' do
      expect(HSS::VERSION).to match /\d+\.\d+\.\d+/
    end
  end

  describe '#initialize' do
    it 'creates Handler objects' do
      expect(HSS.new(config: config)).to be_an_instance_of HSS::Handler
    end
  end

  describe HSS::Handler do
    describe '#initialize' do
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

    describe '#handle' do
      it 'matches input to patterns' do
        expect(handler.handle 'g').to eql 'git@github.com'
      end
      it 'supports regex capturing' do
        expect(handler.handle 'cap99').to eql 'server99.example.org'
      end
      it 'supports named captures' do
        expect(handler.handle 'name_a').to eql 'name_ALPHA'
      end
      it 'raises an error if no match is found' do
        expect { handler.handle 'x' }.to raise_exception RuntimeError
      end
      it 'supports combination of helpers' do
        expect(handler.handle 'bar__1_b').to eql 'bar_9_alpha_BETA'
      end
      it 'supports shallow nested operations' do
        expect(handler.handle 'nest_a').to eql 'winner'
      end
      it 'supports deep nested operations' do
        expect(handler.handle 'deep_cat_c').to eql 'CHARLIE'
      end
    end
  end

  describe HSS::Parser do
    let(:parser) { HSS::Parser.new(key: 'value') }

    describe '#initialize' do
      it 'creates a Parser' do
        expect(parser).to be_an_instance_of HSS::Parser
      end
      it 'stores the config for later use' do
        expect(parser.parse('#{@config[:key]}')).to eql 'value'
      end
    end

    describe '#check' do
      it 'compares an input to a short form' do
        expect(parser.check('a', '[a-z]')).to be_true
        expect(parser.check('1', '[a-z]')).to be_false
      end
    end

    describe '#parse' do
      it 'evaluates a long_form using the stored scope' do
        expect(parser.parse('#{$1}')).to eql ''
        parser.check('winner', '([a-z]+)')
        expect(parser.parse('#{$1}')).to eql 'winner'
      end
    end
  end
end
