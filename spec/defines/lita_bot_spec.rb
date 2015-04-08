require 'spec_helper'

describe 'lita::bot', :type => :define do
  let(:facts) { { :path => '/tmp', :id => 0 } }
  let(:pre_condition) { 'class { "lita": }' }
  let(:title) { 'test bot' }

  it { should contain_file('/opt/lita/test_bot') }
  it { should contain_file('/opt/lita/test_bot/Gemfile') }
  it { should contain_file('/opt/lita/test_bot/lita_config.rb') }
  it { should contain_exec('bundle_install_test_bot') }
  it { should contain_file('/usr/lib/systemd/system/lita@test_bot.service.d') }
  it { should contain_service('lita_test_bot') }

end
