HR System
====

Local setup
---

- Requirements
  - [Virtualbox](https://www.virtualbox.org) >=4.2
  - [Vagrant](https://www.vagrantup.com) >=1.6


- Download host OS image for docker host OS.
```
% vagrant box add precise64 http://files.vagrantup.com/precise64.box
```


- Build Docker images and run containers.
  - This would take 30 minutes.
  - Password of your host OS is required to mount current directory by NFS.
```
% vagrant up
```


- Then access to http://localhost:3000/cars


Usage
---

- `d` command is utility for rails development.

```
Usage : ./d command
Commands:
rc - Rails Console
rdbm - Migrate Database
restore-db - Restoring drop db, migrate and put seed
restart - Restart rails app after bundling gems
rebuild - Rebuild the docker container with latest Gemfile and restart
cmd "bundle exec something" - Run the command in quotes in /app
```


- To execute rspec
```
% ./d cmd bundle exec rspec
```


- To execute `bundle install`
```
% ./d restart
```

- To stop host machine, shutdown the Docker host OS on Virtualbox.
```
% vagrant halt
```

- Just want to get a rails server instance.
```
$ docker run -it -v /app:/app --link redis:redis --link mysql:db rails:latest /bin/bash
```

- To acquire console of rails server
  - To exit the console, `Ctrl + Z` or `Ctrl + C`
```
$ docker attach --sig-proxy=false rails
```




Rebuild
---

- Rebuild from VirtualBox VM
 - This takes 30 minutes.
```
% vagrant destroy && vagrant up
```

- Rebuild docker images by referring Dockerfile.
  - This uses docker image cache.
  - `bundle install` will be ran.
  - This takes 5 minutes.
```
% vagrant provision
```



Issues
---
- MySQL's permission for docker allows connection from anywhere.
  - I'd like to restrict MySQL incoming connection from rails server and host computer.




Expressions
---

- `%` indicates prompt of host computer.
- `$` indicates prompt of VirtualMachine(=docker host) on vagrant.
- `#` indicates prompt of Docker container.


