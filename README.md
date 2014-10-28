centos-controller
=================

Vagrant/Ansible recipe for an AppDynamics controller on CentOS 6.5.

## Purpose

This recipe takes a stock CentOS image, downloads the latest AppDynamics Controller from the internal
Nexus repo, and install it with a demo license.

You can start a new controller just by typing `vagrant up` and waiting a few minutes. 

## Prerequisites

 * You must have [VirtualBox](https://www.virtualbox.org/), [Vagrant](https://www.vagrantup.com/), and 
   [Ansible](http://www.ansible.com/home) installed.
 * You must be connected to the VPN.

## Installation

To download the recipe and start a controller:

``` bash
git clone https://github.com/tradel/centos-controller.git
cd centos-controller
vagrant up
```

Once everything finishes, you should have a controller up and running on [localhost](http://localhost:9090/controller/).
See below for logins and passwords.

## Passwords

| Role | Password |
| :--- | :------- |
| MySQL root user | singcontroller |
| Root account | changeme |
| Initial user | user1 |
| Initial password | welcome |

## Shell access

To log in to the box, try `vagrant ssh`. The controller runs under an `appd` account, so the full sequence would 
go something like this:

``` bash
vagrant ssh
sudo -i
su - appd
```

## Switching controller versions

The recipe is currently set up to install 3.9.4.1. To install a different version, open the file 
`provision/controller/vars/main.yml` and change the values of `nexus_build` and `nexus_version` to match
what you want.
