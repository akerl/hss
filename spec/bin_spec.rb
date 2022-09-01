require 'spec_helper'

describe 'HSS script' do
  before :all do
    ENV['HSS_CONFIG'] = './spec/test/config.yml'
  end

  it 'prints the version' do
    expect(`hss version`.strip).to match(/\d+\.\d+\.\d+/)
  end
  it 'prints a list of examples' do
    expect(`hss`.split("\n").first).to eql 'How to use:'
  end
  it 'supports a debug parameter' do
    ENV['HSS_DEBUG'] = 'yes'
    expect(`hss g`.strip).to eql 'ssh git@github.com'
    ENV.delete 'HSS_DEBUG'
  end
  it 'support overriding the base command' do
    ENV['HSS_COMMAND'] = 'echo'
    expect(`hss g`.strip).to eql 'git@github.com'
    ENV.delete 'HSS_COMMAND'
  end
  # it 'connects via SSH' do
  #  expect(`hss l echo 'hello \\"world\\"'`.strip).to eql 'hello "world"'
  # end
  # it 'connects via SCP' do
  #  `scp -S hss spec/test/config.yml l:#{Dir.pwd}/scp_test`
  #  expect(File.exist?('scp_test')).to be_truthy
  # end
end
