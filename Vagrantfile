Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-12.04.3-server-amd64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.provider "vmware_fusion" do |vm, override|
    override.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/ubuntu-12.04.3-amd64-vmwarefusion.box"
  end
  config.vm.network :private_network, ip: "33.33.33.10"
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.provision :shell, inline: %Q{
    sudo apt-get update
    sudo apt-get install -y linux-image-generic-lts-raring linux-headers-generic-lts-raring
  }
  config.vm.provision :shell, path: "docker/host.sh"
  config.vm.synced_folder "./", "/vagrant", type: "nfs"
end
