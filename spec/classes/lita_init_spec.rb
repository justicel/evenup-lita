require 'spec_helper'

describe 'lita', :type => :class do

  it { should create_class('lita') }
  it { should contain_user('lita') }
  it { should contain_group('lita') }
  it { should contain_file('/opt/lita') }
  it { should contain_file('/usr/lib/systemd/system/lita@.service') }
  it { should_not contain_package('bundler') }

  context 'with bundler' do
    let(:params) { { :manage_bundler => true } }
    it { should contain_package('bundler') }
  end

end

