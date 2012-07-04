# Put vagrant in /etc/hosts
puts "Loading Vagrant.rb"

set :port, 2222 # %x{vagrant ssh-config | grep Port | awk '{ print $2 }'}
set :user, "vagrant"

set :deploy_via, :copy

role :web, "vagrant"
role :app, "vagrant"
#role :db,  "vagrant", :primary => true

set :graphite_host, "localhost"
set :graphite_port, "2003"

server "vagrant", :app, :web

