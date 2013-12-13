---
title: Create a development and production box with Vagrant and Chef
summary: Share the same configuration for local and production environments
tags: Ruby, Rails, Chef
---

Install Vagrant: http://docs.vagrantup.com/v2/installation/
Install Virtual Box: https://www.virtualbox.org/wiki/Downloads

Install dependencies:
```shell
gem install berkshelf
```

Ubuntu vagrant images:
http://cloud-images.ubuntu.com/vagrant/

Init the Vagrant VM:
```shell
vagrant init ubuntu-12.04-server-amd64 http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box
vagrant up
``

Check that the VM works:
```shell
vagrant ssh
```

Install the cookbooks
berks install --path cookbooks

Install chef on VM
vagrant plugin install vagrant-omnibus

In Vagrantfile
```ruby
Vagrant.configure("2") do |config|

  config.omnibus.chef_version = :latest

  ...

end
```

Create the Chef directory structure:

```shell
knife solo init
```

