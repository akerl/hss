require 'spec_helper'

describe HSS::Parser do
  let(:config) { 'spec/test/config.yml' }
  let(:handler) { HSS::Handler.new config }

  describe '#command' do
    it 'runs shell commands' do
      expect(handler.handle('cmd_bar')).to eql 'bar@example.org'
    end
    context 'if the command is invalid' do
      it 'raises an error' do
        expect { handler.handle 'failcmd_zsxdcf' }.to raise_error RuntimeError
      end
    end
    context 'if the command is not executable' do
      it 'raises an error' do
        expect { handler.handle 'failcmd_LICENSE' }.to raise_error RuntimeError
      end
    end
    context 'if the command fails' do
      it 'raises an error' do
        expect { handler.handle 'failcmd_false' }.to raise_error RuntimeError
      end
    end
  end
end
