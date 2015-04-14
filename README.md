# Magnolia Developement Box
This Vagrant Box contains a ready to use developer environment for Magnolia CMS

## Features
- Ready to use developer environment with GIT, maven, docker.
- Run the box on your computer or on Amazon AWS.
- Debug magnolia with instant reload of resources, code and templates.
- Contains a sample Magnolia project to quickstart your own project.

## Installation

### Locally
1. Install Vagrant (http://www.vagrantup.com/downloads)
2. Check out this projet:
   ```git clone https://github.com/nicolasbarbe/magnolia-vagrant.git```
3. From the magnolia-vagrant project, execute this command to start the box:
   ```vagrant up --provider=virtualbox```
   
You can create a shortcut on your destkop or use an alias as your convenience.
### Amazon

The following procedure is only valid for Linux or MacOSX

1. Install Vagrant (http://www.vagrantup.com/downloads)
2. Check out this projet:
   ```git clone https://github.com/nicolasbarbe/magnolia-vagrant.git```
3. Add a new Security Group called magnolia-dev-env with the ports followings ports opened: 
 - 22 (ssh),
 - 80 (http), 
 - 1043 (jpda), 
 - 1099 (jmx),
 - 8080 (http), 
4. If you don't have any key-pairs available, create a new one and save it on your computer. For instance
   `
   ssh/magnolia_dev_env.pem
   `
5. Set the following environment variables at the end of your profile `vi ~/.profile`:
   `
   export AWS_KEY='ABCDEFGHIJKLMNOPQ'
   export AWS_SECRET='WERREGregERGIg4rkgjergiu'
   export AWS_KEYNAME='your_aws_key_name'
   export AWS_SSH_KEYPATH='~/.ssh/magnolia_dev_env.pem'
   `
6. From the magnolia-vagrant project, execute this command to start the box:
```
vagrant up --provider=aws
```

## Configuration
See comments in the file ./Vagrantfile
