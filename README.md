# Mining Map

## Development Environment Setup

This project is using Vagrant as development environment. It is a
wrapper around different virtual machine / container / server providers.
In this case, it is configured to use Virtualbox or LXC for a smaller
ressource footprint. The properties of the virtual machine are
configured in the Vagrantfile.

 - install Virtualbox or LXC (Linux Hosts only)
  - Vagrant instructions: http://docs.vagrantup.com/v2/installation/index.html
  - LXC instructions: https://github.com/fgrehm/vagrant-lxc
 - clone Repository
 - run vagrant:

```bash
# start or resume virtual machine (runs the provisioning, if there wasnt a saved state) :
vagrant up [--provider=lxc]
# ssh into virtual machine as user vagrant:
vagrant ssh
# save virtual machine and turn off
vagrant suspend
# destroy virtual machine before rebuilding it:
vagrant destroy
```

 - log in to work inside the VM:

```bash
vagrant ssh

# change to synced directory
cd /srv/mining-map
```
