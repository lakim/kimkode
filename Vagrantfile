Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-12.04-server-amd64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.provider "vmware_fusion" do |vm, override|
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
  end
  config.vm.network :private_network, ip: "33.33.33.10"
  config.vm.provision "shell", inline: %Q{
    sudo apt-get update
    sudo apt-get install -y linux-image-generic-lts-raring linux-headers-generic-lts-raring
  }
  config.vm.provision "docker"
  config.vm.provision "shell", path: "docker/host.sh"
  config.vm.synced_folder "./", "/vagrant", type: "nfs"
end
