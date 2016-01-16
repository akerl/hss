require 'spec_helper'

describe HSS::Parser do
  let(:config) { 'spec/test/config.yml' }
  let(:handler) { HSS::Handler.new config }

  describe '#shortcut' do
    it 'expands shortcut text' do
      expect(handler.handle('short_a')).to eql 'short_ALPHA'
      expect(handler.handle('short_b')).to eql 'short_BETA'
    end
    context 'when an invalid shortcut is used' do
      it 'raises an error' do
        expect { handler.handle 'short_z' }.to raise_error NameError
      end
    end
  end
end
