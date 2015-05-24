include_recipe 'apt'

include_cookbook 'apache2'
include_cookbook 'mysql'
include_cookbook 'php'
include_cookbook 'concrete5'

include_recipe 'apache2::sites'
