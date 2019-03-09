Virtual Machine Appliance Build
===============================
This directory contain all resources required to build CentOS virtual machine appliances.

Requirements
------------
To build an virtual machine image the following tools are needed:
* Packer
* VirtualBox
* Make

> To develop and debug ansible roles it recomended to also have vagrant installed

Build Steps
-----------
The build consists of the following steps:
1. CentOS base installation through the Kickstart file.
2. Shell provisoner to bootstrap Ansible
3. Ansible provisioner to provision the virtual machine
4. Shell provisoner to install VirtualBox guest additions
5. Compress post-processor to compress .ova file

Known Issues
------------
* Don't run the build as root user. Ansible will fail with an "You need to be root to perform this
  command.". The root cause for this is unclear.

FAQ
---
### How do I add a new PDF guide to the virtual machine?
To add new guides to the virtual machine simply extend `specchio_client_guides` in the following [file](ansible/roles/specchio_client/defaults/main.yml). (Also ensure the the file with exact same name exists in the [Guide repository](https://github.com/SPECCHIODB/Guides/).
