require 'spec_helper'

describe HSS do
  describe '::VERSION' do
    it 'follows the semantic version scheme' do
      expect(HSS::VERSION).to match /\d+\.\d+\.\d+/
    end
  end

  describe '#new' do
    it 'creates Handler objects' do
      expect(HSS.new).to be_an_instance_of HSS::Handler
    end
  end

  describe HSS::Handler do
    describe '#load_config' do
    end
  end
end
