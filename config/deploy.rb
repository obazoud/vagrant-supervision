puts "Loading Deploy.rb"

set :stages, ["vagrant", "staging", "production"]
set :default_stage, "vagrant"
require 'capistrano/ext/multistage'

set :application, "rest-simple"
set :scm, :none

set :war, "/home/olivier/.m2/repository/org/examples/rest/simple/1.0-SNAPSHOT/simple-1.0-SNAPSHOT.war"
set :tomcat_home, "/usr/local/tomcat/tomcat7"

