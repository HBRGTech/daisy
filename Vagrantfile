# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "daisy-pattern-lab-ubuntu-14-04-64"

  config.vm.box_url = "https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-puppet/versions/1.0.0/providers/virtualbox.box"

  config.vm.hostname = "daisy.pattern.lab"

  config.vm.network :forwarded_port,
    guest: 22,
    host: 2022,
    id: "ssh",
    auto_correct: true

  config.vm.network :forwarded_port,
    guest: 35729,
    host: 35729,
    id: "livereload",
    auto_correct: true

  config.vm.network :private_network, ip: "192.168.33.20"

  # Forward X11 so dev sites can be hit more easily over VPN
  config.ssh.forward_x11 = true
  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision :shell, :inline => "apt-get update --fix-missing"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "site.pp"
  	 puppet.module_path = "puppet/modules"
  end

end
