projectsRoot = ENV['PROJECTS_ROOT'] || './projects'

Vagrant.configure(2) do |config|
  
  # network
  config.vm.network "private_network", ip: "10.1.2.3"
  config.vm.hostname = "magnolia-dev-env"

  # provisioning
 config.vm.provision :shell, path: "./scripts/bootstrap.sh"
 config.vm.provision :shell, path: "./scripts/user-config.sh", privileged: false
  
  # folder sync
 config.vm.synced_folder ".", "/vagrant", disabled: true
 config.vm.synced_folder ".", "/magnolia", type: "rsync", rsync__exclude: ["projects/", ".DS_Store"] 
 config.vm.synced_folder projectsRoot, "/magnolia/projects", type: "rsync", rsync__exclude: ["target/", ".idea", ".DS_Store"] 
 # config.vm.synced_folder projectsRoot, "/magnolia/projects", type: "nfs"
 

  # configure provider
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

end


