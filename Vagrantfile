# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # config.vm.box = "ubuntu/utopic64"
  # using lxc as provider requires a special base box:
  config.vm.box = "fgrehm/trusty64-lxc"

  config.vm.network :forwarded_port, host: 5433, guest: 5432

  config.vm.synced_folder ".", "/srv/mining-map/"

  config.vm.provider "virtualbox" do |vb|
   vb.memory = "512"
   vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

  config.vm.provider :lxc do |lxc|
    lxc.customize 'cgroup.memory.limit_in_bytes', '1000M'
  end

  config.vm.provision "shell", path: "provisioning/provision.sh"
end
