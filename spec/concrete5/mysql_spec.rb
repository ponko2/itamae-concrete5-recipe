require 'spec_helper'

%w(mysql-server mysql-client libmysqlclient-dev).each do |p|
  describe package(p) do
    it { should be_installed }
  end
end

describe service('mysql') do
  it { should be_enabled }
  it { should be_running }
end
