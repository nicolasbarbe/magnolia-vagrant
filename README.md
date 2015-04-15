# Magnolia Developement Box
This Vagrant Box contains a ready to use developer environment for Magnolia CMS

## Features
- Ready to use developer environment with GIT, maven, docker.
- Debug magnolia with instant reload of resources, code and templates.
- Contains a sample Magnolia project to quickstart your own project.

## Installation

1. Install Vagrant: http://www.vagrantup.com/downloads

2. Check out this projet:
   
   ```
   git clone https://github.com/nicolasbarbe/magnolia-vagrant.git
   ```

3. From the magnolia-vagrant project, execute this command to start the box:

   ```
   vagrant up
   ```

You can create a shortcut on your destkop or use an alias as your convenience.
   
By default, your projects must be located under the directory `./magnolia-vagrant/projects` on the host. They are mapped to the directory `/magnolia/projects` on the guest.

You can override the host directory setting the environment variable `PROJECTS_ROOT` or starting the box with this command:

   ```
   PROJECTS_ROOT='~/myprojects' vagrant up
   ```

## Configuration
See comments in the file ./Vagrantfile
