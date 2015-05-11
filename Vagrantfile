Vagrant.configure(2) do |config|
  config.vm.box = "bseller/oracle-standard"
  config.vm.define :oracle do |oracle| 
    oracle.vm.hostname = 'oraclebox'
    oracle.vm.synced_folder ".", "/vagrant", owner: "oracle", group: "oinstall" 
    oracle.vm.network :private_network, ip: '192.168.33.13'
    oracle.vm.network :forwarded_port, guest: 1521, host: 1521
    oracle.vm.provider :virtualbox do |vb|
       vb.customize ["modifyvm", :id, "--memory", "4096"]
       vb.customize ["modifyvm", :id, "--name", "oraclebox"]
       if !File.exist?("disk/oracle.vdi")
         vb.customize [
              'createhd', 
              '--filename', 'disk/oracle', 
              '--format', 'VDI', 
              '--size', 60200
              ] 
         vb.customize [
              'storageattach', :id, 
              '--storagectl', "SATA", 
              '--port', 1, '--device', 0, 
              '--type', 'hdd', '--medium', 'disk/oracle.vdi'
              ]
       end     
    end
    oracle.vm.provision "shell", path: "shell/add-oracle-disk.sh"
    oracle.vm.provision "shell", path: "shell/provision.sh"
  end
end
