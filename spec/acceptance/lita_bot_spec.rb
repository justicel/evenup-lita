require 'spec_helper_acceptance'

describe 'lita bot' do

  context 'configure bot' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'lita': bundler_binpath => '/usr/bin' }
      lita::bot { 'test bot':
        adapter        => ':irc',
        adapter_config => { 'server' => 'irc.freenode.net', 'channels' => ['#litabot'] }
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe file('/opt/lita/test_bot/Gemfile') do
      it { should be_file }
    end

    describe file('/opt/lita/test_bot/lita_config.rb') do
      it { should be_file }
    end

    describe port(8080) do
      it { should be_listening }
    end

  end # configure bot

end
