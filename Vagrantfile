# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # See online documentation at vagrantup.com for more options.

  config.vm.box = "hashicorp/precise64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    #vb.gui = true
  
    # Use 3.75GB VMs, same as AWS m1.medium and m3.medium
    vb.customize ["modifyvm", :id, "--memory", "3840"]
  end

  config.vm.define "client" do |client|
    config.vm.network "private_network", ip: "192.168.99.1"
  end

  config.vm.define "server" do |server|
    config.vm.network "private_network", ip: "192.168.99.2"
  end

end
