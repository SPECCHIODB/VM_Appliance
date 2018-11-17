Virtual Machine Appliance Build
===============================
This directory contain all resources required to build CentOS virtual machine appliances.

Requirements
------------
To build an virtual machine image the following tools are needed:
* Packer
* VirtualBox
* Make

To develop and debug ansible roles it recomended to also have to following tools installed:
* Ansible
* Vagrant

Development
-----------
For testing purposes we're using vagrant and it's included ansible provisoner. This way we don't
need to wait on the CentOS base installation everytime we wan't to test our roles.

```
# On the first run
$ vagrant up
# To rerun the playbook
$ vagrant provision
```
