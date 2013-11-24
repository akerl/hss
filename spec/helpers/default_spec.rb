require 'spec_helper'

describe HSS::Parser do
  let(:config) { 'spec/test/config.yml' }
  let(:handler) { HSS::Handler.new config }

  describe '#default' do
    it 'uses the provided value if set' do
      expect(handler.handle 'def_77').to eql 'chose_77'
    end
    it 'uses the default if the value is unset' do
      expect(handler.handle 'def_').to eql 'chose_10'
    end
  end
end
