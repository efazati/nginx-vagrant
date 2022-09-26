Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 256]
  end

 config.vm.define :nginx do |nginx_config|

    nginx_config.vm.hostname = 'nginx'
    nginx_config.vm.network :private_network, ip: "192.168.58.100"
    nginx_config.vm.provision "file", source: "files/nginx", destination: "$HOME/files"
    nginx_config.vm.provision :shell, :path => "nginx.sh"

  end
end
