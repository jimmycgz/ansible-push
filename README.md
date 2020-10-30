# ansible-push
Use Ansible to deployments to multiple EC2, the IP list can be generated by bash script calling awscli

## Why ansible ? What's the meaning of Configuration Management? 

Assume you manage multiple group of VMs across GCP, AWS and Azure like below and you want to efficiently deploy the specified versions to them several times a week.

 > stage: 1 api and 2 workers using aws ec2
 
 > prod1: 2 api and 10 workers using gcp vm
 
 > prod2: 2 api and 5 workers using azure vm
 
To manage the versions of your services on the above groups need a powerful tool to manage the configuration and execute some script as needed. Then below steps will make your life easier:
```
* Install ansible on your local 
* Create hosts list with specified ssh private key on your local folder ansible/hosts.ini
* Specify service versions in ansible/service/versions.json
* Maintain secrets and other configurations in ansible/service/config.json
* Develop script ansible/service/run.sh for how to download and launch the services on remote server
* Copy updated files (versions.json, config.json, run.sh) from local to remote server by ansible playbook
* Excute the script at remote servers to launch the services defined in the playbook
```

![Diagram1](https://github.com/jimmycgz/ansible-push/blob/master/ansible-push.png)

## Problem to resolve:

### How to get a list of public(private) IPS by tag or from a scaling group of EC2 ?

Refer to the script ec2-ips.sh

Feature 1: Get a list of instance ids via describe a scaling group, then get the IP for each instance via describe isntance.

Feature 2: Get a list of instances by --filter option on describe instance by tag.


### How to deploy to stage first and then to prod after testing on stage ?

Step 1: create stage and prod groups in hosts.ini

Step 2: create makefile with different deploy commands

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




