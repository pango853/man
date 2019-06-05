

> vagrant init hashicorp/precise64
> vagrant up -provider=hyperv

```
	config.vm.provision "shell", :path => "provision_init.sh" :privileged => false
```



```Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

# REF: https://www.vagrantup.com/docs/hyperv/configuration.html

Vagrant.configure("2") do |config|
	config.vm.provider :hyperv # !!! Hardcoded HERE !!!

	config.vm.define "master" do |subconfig|
		subconfig.vm.box = "centos/7"
		subconfig.vm.provider :hyperv do |provider|
			#provider.vmname = "master"

			provider.cpus = 1
			provider.memory = 2048
			provider.maxmemory = 2048
		end
		subconfig.vm.network :private_network, bridge: "nat"
		#subconfig.vm.provision "docker"
	end

	config.vm.define "node1" do |subconfig|
		subconfig.vm.box = "centos/7"
		subconfig.vm.provider :hyperv do |provider|
			#provider.vmname = "node1"

			provider.cpus = 1
			provider.memory = 2048
			provider.maxmemory = 2048
		end
		subconfig.vm.network :private_network, bridge: "nat"
		#subconfig.vm.provision "docker"
	end
```