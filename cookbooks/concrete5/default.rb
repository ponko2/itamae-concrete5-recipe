require 'itamae/plugin/resource/wget'

node.validate! do
  {
    concrete5: {
      download_url: string,
      version: string,
      install_path: string
    }
  }
end

package 'unzip'

download_path = '/var/tmp/concrete5.zip'
install_path  = Shellwords.escape(node[:concrete5][:install_path])
unzip_path    = "/var/tmp/concrete#{Shellwords.escape(node[:concrete5][:version])}"

wget download_path do
  source node[:concrete5][:download_url]
  not_if "test -f #{download_path}"
end

execute 'extract compressed files' do
  command 'unzip concrete5.zip'
  cwd '/var/tmp'
  not_if "test -d #{unzip_path}"
  notifies :run, 'execute[move files]', :immediately
end

execute 'move files' do
  action :nothing
  command "mv #{unzip_path} #{install_path}"
  not_if "test -d #{install_path}"
  only_if "test -d #{unzip_path}"
end

%w(
  packages
  updates
  application/config
  application/files
  application/themes
).each do |directory|
  execute 'change file owner and group' do
    command "chown -R root:www-data #{directory}"
    cwd install_path
  end

  execute 'change file mode bits' do
    command "chmod -R 775 #{directory}"
    cwd install_path
  end
end
