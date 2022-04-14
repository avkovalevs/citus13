Deploy Citus cluster with cstore_fdw
==================

Install Postgresql Citus cluster Community Edition  - https://www.citusdata.com/. Tested with Citus 9.5 with PG 13 on Ubuntu 20.04.

Requirements
------------

PostgreSQL 13, Citus 9.5, Ansible 2.9.16, python3  open ports (22 from anywhere, 5432 and 9700 inside the private network) 

Role Variables
--------------

Steps to deploy citus cluster (all steps from root user):
1. Install latest ansible package on master node (in my case dbsrv2): 
~~~
$ sudo apt install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt update
$ sudo apt install ansible
~~~
2. Get the code on master node: 
~~~ 
$ cd /etc/ansible && git clone https://github.com/avkovalevs/citus.git
~~~
3. Generate public and private keys for root user on master node (Enter->Enter): 
~~~
$ cd ~
$ ssh-keygen -t rsa
~~~
Steps 4-6 needs for passwordless access between nodes for ansible-playbook tuning steps.

4. Check in /etc/ssh/sshd_config file parameters "PasswordAuthentication yes" and "PermitRootLogin yes" installed and restart sshd service on all nodes before step 5.
~~~
$ systemctl restart ssh
~~~

For step 5 you need to know root password. You can use your own hostnames (in my case node1, node2, node3.) 

5. Copy public key from ansible-master node to all pg nodes including master(root->root): 

~~~
$ cd ~
$ ssh-copy-id -i ~/.ssh/id_rsa.pub root@node1
$ ssh-copy-id -i ~/.ssh/id_rsa.pub root@node2
$ ssh-copy-id -i ~/.ssh/id_rsa.pub root@node3
~~~
For AWS cloud nodes use passwordless access for master-target (root->ubuntu).
6. Set "PasswordAuthentication no" changed in step 4 and restart ssh like "systemctl restart ssh.service" on all nodes.
7. Change ./roles/citus/defaults/main.yml and inventory file "hosts" on your own ip addresses depend on number of nodes.
8. Run the playbook to deploy cluster
~~~
$ cd /etc/ansible/citus
$ ansible-playbook -v -i hosts citus.yml --extra-vars "env_state=present"
~~~
You can create prod, dev or test inventory files instead of hosts and use it with -i options.

License
-------

BSD

Author Information
------------------
Alex Kovalev
