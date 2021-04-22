Vagrant.configure("1") do |config|
    config.vm.box = ENV["VAGRANT_BOX"]
    config.vm.hostname = "ansible-elastic-baremetal"
  
    config.vm.provider "virtualbox" do |p|
      p.cpus = ENV['VAGRANT_VM_CPUS'] || 4
      p.memory = ENV['VAGRANT_VM_MEMORY'] || 2048

      #p.customize [
      #    'storageattach', :id,
      #    '--storagectl', 'IDE Controller',
      #    '--port', 0,
      #    '--device', 0,
      #    '--type', 'dvddrive',
      #    '--medium', "#{ENV['VAGRANT_MEDIA']}"
      #]

      p.customize [
          "createmedium", "disk",
          "--filename", "ansible-elastic-baremetal-data.vmdk", 
          "--format", "vmdk",
          "--size", 1024 * 10
      ]

      p.customize [
          "storageattach", "ansible-elastic-baremetal" ,
          "--storagectl", "IDE Controller",
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