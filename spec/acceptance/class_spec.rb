require 'spec_helper_acceptance'

describe 'lita classes' do

  context 'install/configure' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'redis': }
      class { 'lita':
        manage_bundler   => true,
        bundler_package  => 'rubygem-bundler',
        bundler_provider => 'yum',
        extra_packages   => [ 'ruby-devel', 'openssl-devel', ],
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe file('/opt/lita') do
      it { should be_directory }
    end

  end # install/config

end
