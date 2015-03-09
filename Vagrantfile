# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'fileutils'

VAGRANTFILE_API_VERSION = "2"

HOSTS=[ 
  { :hostname => 'client', :ip => '192.168.99.10' },
  { :hostname => 'server', :ip => '192.168.99.20' },
]

OUTDIRS = [ 'data/vagrant', 'data/vagrant-small']
OUTDIRS.each do |outdir|
  FileUtils.mkdir_p outdir
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # See online documentation at vagrantup.com for more options.

  config.vm.box = "hashicorp/precise64"

  config.vm.provider "virtualbox" do |vb|
    # Use 3.75GB VMs, same as AWS m1.medium and m3.medium
    vb.customize ["modifyvm", :id, "--memory", "3840"]
  end

  # config.vm.define "default"

  HOSTS.each do |host|
  config.vm.define host[:hostname] do |box|
    box.vm.hostname = host[:hostname]
    box.vm.network "private_network", ip: host[:ip]
    HOSTS.each do |host|
      box.vm.provision "shell", inline: <<-EOF
        sudo sed -i -e '/#{host[:hostname]}/d' /etc/hosts
        sudo sed -i -e '2a#{host[:ip]}  #{host[:hostname]}' /etc/hosts
      EOF
    end
    box.vm.provision "shell", inline: <<-EOF
      sudo apt-get update
      sudo apt-get install make
      cd /vagrant
      make "#{host[:hostname]}"
    EOF
    if host[:hostname] == "server"
      box.vm.provision "shell", inline: <<-EOF
        /vagrant/competition/start-supervisord.sh
      EOF
    end
  end
  end

end
