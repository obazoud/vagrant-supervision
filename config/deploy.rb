set :application, "rest-simple"
set :scm, :none

set :port, 2200 # %x{vagrant ssh-config | grep Port | awk '{ print $2 }'}
set :user, "vagrant"

set :war, "/home/olivier/.m2/repository/org/examples/rest/simple/1.0-SNAPSHOT/simple-1.0-SNAPSHOT.war"
set :tomcat_home, "/usr/local/tomcat/tomcat7"

role :web, "localhost"
#role :app, "vagrant"
#role :db,  "vagrant", :primary => true

set :deploy_via, :copy

