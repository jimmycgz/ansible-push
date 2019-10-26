# ansible-push
Use Ansible to deployments to multiple EC2, the IP list can be generated by bash script calling awscli

## Problem to resolve:

* How to get a list of public(private) IPS by tag or from a scaling group of EC2 ?

Refer to the script ec2-ips.sh

Feature 1: Get a list of instance ids via describe a scaling group, then get the IP for each instance via describe isntance.
Feature 2: Get a list of instances by --filter option on describe instance by tag.


* How to deploy to stage first and then to prod after testing on stage ?

Step 1: create stage and prod groups in hosts.ini

Step 2: create makefile with different configurations

Step 3: run below lines to deploy separately

```
make stg
make prod

```



## More information:

* Install ansible on ubuntu from ppa
```
refer to https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-16-04
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
ansible --version
```
* Ansible from zero to hero
https://symfonycasts.com/screencast/ansible/vagrant-ansible#play




