require 'spec_helper'

%w(
  packages
  updates
  application/config
  application/files
  application/themes
).each do |directory|
  describe file("/var/www/concrete5/#{directory}") do
    it { should be_directory }
    it { should be_readable.by_user('www-data') }
    it { should be_writable.by_user('www-data') }
  end
end
