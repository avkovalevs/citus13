Deploy Citus cluster with cstore_fdw
==================

Install Postgresql Citus cluster Community Edition  - https://www.citusdata.com/. Tested with Citus 9.5 with PG 13 on Ubuntu 18.04.

Requirements
------------

PostgreSQL 13, Citus 9.5, Ansible 2.9.16, open ports (22 from anywhere, 5432 and 9700 inside the private network) 

Role Variables
--------------

Steps to deploy citus cluster:
1. Install latest ansible package on master node: 
~~~
$ sudo apt install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt update
$ sudo apt install ansible
~~~
2. Get the code: 
~~~ 
cd /etc/ansible && git clone https://github.com/avkovalevs/citus.git
~~~
3. Generate public and private keys for root user on master node: 
~~~
ssh-keygen -t rsa
~~~
4. Check in /etc/ssh/sshd_config file parameters "PasswordAuthentication yes" and "PermitRootLogin yes" installed and restart sshd service on all nodes before step 5.
5. Copy public key from master node to all nodes including master(root->root): 
~~~
ssh-copy-id -i ~/.ssh/id_rsa.pub root@node1
ssh-copy-id -i ~/.ssh/id_rsa.pub root@node2
ssh-copy-id -i ~/.ssh/id_rsa.pub root@dbsrv2
~~~
6. Set "PasswordAuthentication no" changed in step 4 and restart ssh like "systemctl restart ssh.service" on all nodes.
7. Change ./roles/citus/defaults/main.yml and inventory file "hosts" on your own depend on number of nodes.
8. Run the playbook to deploy cluster
~~~
ansible-playbook -v -i hosts citus.yml --extra-vars "env_state=present"
~~~


License
-------

BSD

Author Information
------------------
Alex Kovalev
