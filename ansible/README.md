Ansible Roles and Playbooks
===========================

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

### Database Reset
In case you need to reset the database:
``` sql
DROP DATABASE specchio
DROP DATABASE specchio_temp
DROP USER 'sdb_admin'@'localhost';
```
