# Commands required to setup working docker enviro, link
# containers etc.
$setup = <<SCRIPT
# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Build containers from Dockerfiles
docker build -t mysql /app/docker/mysql
docker build -t rails /app
docker build -t redis /app/docker/redis/

# Run and link the containers
docker run -d --name mysql -e DB_NAME=dpa_development -e DB_USER=docker -e DB_PASS=docker mysql:latest
docker run -d --name redis redis:latest
docker run -d -p 3000:3000 -v /app:/app --link redis:redis --link mysql:db --name rails rails:latest

SCRIPT

# Commands required to ensure correct docker containers
# are started when the vm is rebooted.
$start = <<SCRIPT
docker start mysql
docker start redis
docker start rails
docker run -v /app:/app --link redis:redis --link mysql:db --rm rails:latest bash -c "cd /app && sleep 3 && bundle exec rake db:create db:migrate"
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|

  # Setup resource requirements
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # need a private network for NFS shares to work
  config.vm.network "private_network", ip: "192.168.50.4"

  # Rails Server Port Forwarding
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Ubuntu
  config.vm.box = "ubuntu/trusty64"

  # Install latest docker
  config.vm.provision "docker"

  # Must use NFS for this otherwise rails
  # performance will be awful
  config.vm.synced_folder ".", "/app", type: "nfs"

  # Setup the containers when the VM is first
  # created
  config.vm.provision "shell", inline: $setup

  # Make sure the correct containers are running
  # every time we start the VM.
  config.vm.provision "shell", run: "always", inline: $start
end
