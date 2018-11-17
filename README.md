Virtual Machine Appliance Build
===============================
This directory contain all resources required to build CentOS virtual machines.

Packer
======
TBD


Ansible
=======
This directory contains all required playbooks and roles to provision a SPECCHIO server.

Requirements
------------
* Python
* Ansible
* Vagrant

Development
-----------
For testing purposes we're using vagrant with the included ansible provisoner.

```
# On the first run
$ vagrant up
# To rerun the playbook
$ vagrant provision
```
