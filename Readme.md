# Nginx Vagrant

**Technologies:**
- Nginx
- Centos
- Docker
- Vagrant

### Run
To run this project, use `vagrant up`. and then see https://192.168.58.100

Also after that you can ssh to nodes with this command `vagrant ssh`


### Requirement
The only thing that you need is Vagrant https://www.vagrantup.com/docs/installation


### Command
```
sudo tcpdump -i any -nn "port 8002"

ab -n 5000 -c 100 "https://192.168.58.100/app/"
```