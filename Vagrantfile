Vagrant.configure('2') do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'centos/7'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network 'forwarded_port', guest: 8484, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  config.vm.synced_folder './src', '/src/round-robin'
  config.vm.synced_folder '.', '/vagrant', type: 'virtualbox'

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider 'virtualbox' do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = '1024'
  end

  config.vm.provision 'shell', inline: <<-SHELL
    curl https://storage.googleapis.com/golang/go1.7.1.linux-amd64.tar.gz -o /tmp/go1.7.1.linux-amd64.tar.gz
    tar -C /usr/local -xzf /tmp/go1.7.1.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.bash_profile
    sudo yum install wget -y
    wget https://packages.chef.io/stable/el/7/chef-12.15.19-1.el7.x86_64.rpm -O /tmp/chef-12.15.19-1.el7.x86_64.rpm
    sudo rpm -ivh /tmp/chef-12.15.19-1.el7.x86_64.rpm
    sudo rm -rf /tmp/chef-12.15.19-1.el7.x86_64.rpm /tmp/go1.7.1.linux-amd64.tar.gz
  SHELL

  config.vm.provision 'chef_solo' do |chef|
    chef.install = false
    chef.run_list = ['recipe[round-robin::appserver]']
  end
end
