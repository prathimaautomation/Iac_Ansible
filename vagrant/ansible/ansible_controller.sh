#!/bin/bash
sudo apt-get update -y
sudo apt-get install software-properties-common -y

# ensure line 3 executes in the script
sudo apt-add-repository ppa:ansible/ansible -y

sudo apt-get upgrade -y 
sudo apt-get install ansible -y

#to check if setup properly
ansible --version

#to install tree -to view folder structure in a nice way
sudo apt-get install tree

cd /etc/ansible
sudo nano hosts
```hosts
[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
```

ansible all -m ping

##ansible ad-hoc commands
ansible web -a "hostnamectl"
ansible web -a "uname -a"
ansible db -a "date"
#to find out the free space in the agent nodes
ansible all -a "free" 
#
ansible web -m shell -a "ls -a"

#to find out uptime of both the agent nodes
ansible all -a "uptime"

#to check the status of the nginx installed in the agent
ansible web -a "systemctl status nginx"

# to create a playbook
sudo nano nginx.yml

```nginx.yml
---
# define the agent node's name host name

- hosts: web

   # see logs
  gather_facts: yes

   # sudo permision with become = true
  become: true

   # install nginx on web server
  tasks:
  - name: Install nginx
    apt: pkg=nginx state=present
```

#to run the playbook
ansible-playbook nginx.yml

#to create a mongo.yml
sudo nano mongo.yml
```mongo.yml
---
# configuring Mongodb in our db server to connect web

- hosts: db
  gather_facts: yes
  become: true
  tasks:
  - name: install mongodb
    apt: pkg=mongodb state=present

```



