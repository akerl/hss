require 'spec_helper'

describe HSS::Parser do
  let(:config) { 'spec/test/config.yml' }
  let(:handler) { HSS::Handler.new config }

  describe '#external' do
    it 'reads values from a YAML file' do
      expect(handler.handle 'ext_test.first.color').to eql 'external_blue'
    end
    context 'when a key is not found' do
      it 'raises an error' do
        expect { handler.handle 'ext_test.three' }.to raise_error NameError
        expect { handler.handle 'ext_test.five.tree' }.to raise_error NameError
      end
    end
    context 'when the source does not exist' do
      it 'raises an error' do
        expect { handler.handle 'failext_abcd' }.to raise_error RuntimeError
      end
    end
    context 'when the source YAML is invalid' do
      it 'raises an error' do
        expect { handler.handle 'failext_invalid' }.to raise_error RuntimeError
      end
    end
  end
end
