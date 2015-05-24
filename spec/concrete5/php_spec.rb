require 'spec_helper'

describe package('php5') do
  it { should be_installed }
end

describe command('apachectl -M') do
  its(:stdout) { should contain('php5_module') }
end

describe 'PHP modules' do
  describe command('php -m') do
    its(:stdout) { should contain('curl') }
    its(:stdout) { should contain('zip') }
    its(:stdout) { should contain('mcrypt') }
    its(:stdout) { should contain('openssl') }
    its(:stdout) { should contain('gd') }
    its(:stdout) { should contain('mysqlnd') }
    its(:stdout) { should contain('mbstring') }
    its(:stdout) { should contain('iconv') }
  end
end

describe 'PHP config parameters' do
  context php_config('date.timezone') do
    its(:value) { should eq 'Asia/Tokyo' }
  end

  context php_config('post_max_size') do
    its(:value) { should eq '20M' }
  end

  context php_config('memory_limit') do
    its(:value) { should eq '-1' }
  end

  context php_config('allow_url_fopen') do
    its(:value) { should eq 1 }
  end

  context php_config('default_charset') do
    its(:value) { should eq 'UTF-8' }
  end

  context php_config('mbstring.language') do
    its(:value) { should eq 'neutral' }
  end

  context php_config('mbstring.internal_encoding') do
    its(:value) { should eq 'UTF-8' }
  end
end
