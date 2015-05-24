include_recipe 'php'

%w(curl gd mcrypt mysqlnd).each do |m|
  include_recipe "php::module_#{m}"
end

template '/etc/php5/cli/php.ini'
template '/etc/php5/apache2/php.ini'

include_recipe 'apache2::mod_php5'
