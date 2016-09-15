# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.56.110"
  config.vm.hostname = "hadoop.vagrant-local.jbj"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
    v.name = "hadoop"
  end

   #port1 = 5044
   #config.vm.network(:forwarded_port, guest: port1, host: port1)

  config.vm.provision "shell",
    path: "scripts/bootstrap.sh"

  config.vm.provision "shell",
    path: "scripts/keygen.sh"

  config.vm.provision "shell",
    path: "scripts/hadoop.sh"

  config.vm.provision "shell",
    path: "scripts/startup.sh",
  run: "always"
end
