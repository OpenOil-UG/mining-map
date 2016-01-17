#Mining-Map Vagrant Configs


##Installation

Clone the repository into mining-map
```
git clone $repo-url mining-map
cd mining-map
```
Local Mode:
```
cd local-mode
# Make sure virtualbox and virtualbox-extension-box both are installed
vagrant up --provider virtualbox
```
AWS Mode (CPU/GPU):
```
cd aws-cpu-mode #or aws-gpu-mode
# Add dummy aws box
vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
# Make sure vagrant-aws plugin is installed
vagrant plugin install vagrant-aws


cp .mining-map.secret.yml.example .mining-map.secret.yml
#And then edit .mining-map.secret.yml to fill in the necessary details !!

# If you are sharing the control of the same instance between multiple people,
# Ask the creator of the instance to share the `.vagrant` folder from both the
# cpu-mode and gpu-mode Vagrant configs, and place them at their appropriate locations
# At : aws-cpu-mode/.vagrant in case of cpu-mode
# At : aws-gpu-mode/.vagrant in case of gpu-mode

# Let's spawn some VMs!
vagrant up --provider aws
```
