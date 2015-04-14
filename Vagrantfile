
Vagrant.configure(2) do |config|
  
  # network
  config.vm.network "private_network", type: "dhcp"
  config.vm.hostname = "magnolia-dev-env"

  # provisioning
  config.vm.provision :shell, path: "./scripts/bootstrap.sh"
  config.vm.provision :shell, path: "./scripts/user-config.sh", privileged: false
  
  # Share an additional folder to the guest VM. 
  config.vm.synced_folder ".", "/magnolia", type: "rsync", rsync__exclude: [".git/", "target/", ".idea", ".DS_Store"] 
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  # --- 
  # Configure Virtual Box provider
  # ---

  # network redirection 
  config.vm.network :forwarded_port, guest: 9090, host: 9090     # Magnolia CMS author admin interface
  config.vm.network :forwarded_port, guest: 1099, host: 1099     # Magnolia CMS author JMX port
  config.vm.network :forwarded_port, guest: 1043, host: 1043     # Magnolia CMS author jpda debug port
  config.vm.network :forwarded_port, guest:   80, host: 80       # Magnolia CMS public website

  config.vm.provider "virtualbox" do |virtualbox, override|

    override.vm.box = "ubuntu/utopic64"
    override.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/utopic/current/utopic-server-cloudimg-amd64-vagrant-disk1.box"
    override.vm.box_download_checksum = "f049128b25f47a9bd064d856ae636367"
    override.vm.box_download_checksum_type = "md5"

    host = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
    end

    virtualbox.customize ["modifyvm", :id, "--memory", mem]
    virtualbox.customize ["modifyvm", :id, "--cpus", cpus]
  end

  # ---
  # Configure Amazon provider
  # ---

  config.vm.provider :aws do |aws, override|

    # set the environment variables AWS_KEY, AWS_SECRET, AWS_KEYNAME and AWS_SSH_KEYPATH before starting Vagrant
    aws.access_key_id     = ENV['AWS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET']
    aws.keypair_name      = ENV['AWS_KEYNAME']

    # select an image on http://cloud-images.ubuntu.com/locator/ec2/
    aws.ami = "ami-5f9e1028" 
    
    # select a region matching the image
    aws.region = "eu-west-1"

    # set an instance type compatible with the image
    aws.instance_type = "t2.micro"
    
    # configure a security group with the following ports opened: 22, 80, 1043, 1099, 8080, 5900-5950 (remote destkop)
    aws.security_groups = ["magnolia-dev-env"]
     
    override.vm.box = "dummy"
    override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = ENV['AWS_SSH_KEYPATH']
  end 

end


