# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = ENV["VAGRANT_BOX_NAME"]
  config.vm.box_url = ENV["VAGRANT_BOX_URL"]
  config.vm.hostname = "ansible-elastic-baremetal"

  config.vm.provider "virtualbox" do |p|
    p.cpus = ENV['VAGRANT_VM_CPUS'] || 3
    p.memory = ENV['VAGRANT_VM_MEMORY'] || 3072

    unless(File.exist?("ansible-elastic-baremetal-data.vmdk"))
      p.customize [
        "createmedium", "disk",
        "--filename", "ansible-elastic-baremetal-data.vmdk",
        "--format", "vmdk",
        "--size", 1024 * 10
      ]
    end

    p.customize [
      "storageattach", :id,
      "--storagectl", "SATA Controller",
      "--port", "1",
      "--device", "0",
      "--type", "hdd",
      "--medium", "ansible-elastic-baremetal-data.vmdk"
    ]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tests/main.yml"
  end
end
