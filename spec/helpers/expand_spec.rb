require 'spec_helper'

describe HSS::Parser do
  let(:config) { 'spec/test/config.yml' }
  let(:handler) { HSS::Handler.new config }

  describe '#expand' do
    it 'matches keywords in a mapping' do
      expect(handler.handle('exp_a')).to eql 'exp_alpha'
      expect(handler.handle('exp_2')).to eql 'exp_beta'
    end
    context 'when no match is found' do
      it 'raises an error' do
        expect { handler.handle 'exp_c' }.to raise_error NameError
      end
    end
  end
end
