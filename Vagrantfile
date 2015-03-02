# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
client_hostname="wsdemo-client"
server_hostname="wsdemo-server"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # See online documentation at vagrantup.com for more options.

  config.vm.box = "hashicorp/precise64"

  config.vm.provider "virtualbox" do |vb|
    # Use 3.75GB VMs, same as AWS m1.medium and m3.medium
    vb.customize ["modifyvm", :id, "--memory", "3840"]
  end

  # config.vm.define "default"

  config.vm.define "client" do |client|
    config.vm.network "private_network", ip: "192.168.99.1"
    config.vm.provision "shell", inline: <<-EOF
      sudo sed -i -e '/#{client_hostname}/d' /etc/hosts
      sudo sed -i -e '2a127.0.2.1   #{client_hostname}' /etc/hosts
      sudo hostname #{client_hostname}
      sudo apt-get update
      sudo apt-get install make
      cd /vagrant
      make client
      EOF
  end

  config.vm.define "server" do |server|
    config.vm.network "private_network", ip: "192.168.99.2"
    config.vm.provision "shell", inline: <<-EOF
      sudo sed -i -e '/#{server_hostname}/d' /etc/hosts
      sudo sed -i -e '2a127.0.3.1   #{server_hostname}' /etc/hosts
      sudo hostname #{server_hostname}
      sudo apt-get update
      sudo apt-get install make
      cd /vagrant
      make server
      EOF
  end

end
