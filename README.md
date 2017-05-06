## Virtual Development Environment for Ruby on Rails Application

###  Install Vagrant ###

* Download and install [VirtualBox 5.1.6](https://www.virtualbox.org/wiki/Downloads)
* Download and install [Vagrant 1.8.6](http://www.vagrantup.com/downloads.html)
* Download and install [Ansible 2.2.1.0](http://docs.ansible.com/ansible/intro_installation.html)

### Connect to the Virtual Machine ###

Start the virtual machine:

    host $ vagrant up
    
Open your browser and navigate to
	
	192.168.66.66:3000

Another way:

	Connect to the virtual machine via ssh:

	    host $ vagrant ssh

	Try it out!

	    guest $ cd /vagrant
	    guest $ rails server -b 192.168.66.66
