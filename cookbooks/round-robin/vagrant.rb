Vagrant.configure(2) do |config|
  config.vm.provision 'shell', inline: <<-SHELL
     sudo yum install net-tools -y
  SHELL
end
