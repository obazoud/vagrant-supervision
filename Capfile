load 'deploy'
load 'config/deploy'


set :repository do 
  fetch(:deploy_from)
end

set :deploy_from do 
  dir = "/tmp/prep_#{release_name}"
  system("mkdir -p #{dir}")
  dir
end

set :deploy_to do 
  "/usr/local/apps/#{application}"
end

# tomcat server
namespace :tomcat do
  task :stop do
    sudo "/etc/init.d/tomcat7 stop"
  end
  task :start do
    sudo "/etc/init.d/tomcat7 start"
  end
  task :restart do
    tomcat.stop
    tomcat.start
  end
  task :tail do
    stream "tail -f #{tomcat_home}/logs/catalina.out"
  end
end

# graphite
namespace :graphite do
  task :notify_deploy do
    run "echo \"events.deploy.website\" 1 `date +%s` | nc #{graphite_host} #{graphite_port}"
  end
  task :notify_rollback do
    run "echo \"events.deploy.website\" -1 `date +%s` | nc #{graphite_host} #{graphite_port}"
  end
end

#after 'deploy:setup' do
after 'deploy:create_symlink' do
  cmd = "ln -sf #{deploy_to}/current/`basename #{war}` #{tomcat_home}/webapps/`basename #{war}`"
#  cmd = "ln -sf #{deploy_to}/current/`basename #{war}` #{tomcat_home}/webapps/#{application}"
  puts cmd
  sudo cmd
end

before 'deploy:update_code' do
  unless(war.nil?)
    puts "get war"
    system("cp #{war} #{deploy_from}")
    puts system("ls -l #{deploy_from}")
  end
end

# restart
namespace :deploy do
  task :restart do
    sudo "mkdir -p /usr/local/apps/#{application}/releases"
    sudo "chown -R vagrant /usr/local/apps/#{application}"
    graphite.notify_deploy
    tomcat.restart
  end
end

#
# Disable all the default tasks that
# either don't apply, or I haven't made work.
#
namespace :deploy do
  [ :upload, :cold, :start, :stop, :migrate, :migrations].each do |default_task|
    desc "[internal] disabled"
    task default_task do
      puts "[internal] disabled: #{default_task}"
      # disabled
    end
  end

  namespace :web do
    [ :disable, :enable ].each do |default_task|
      desc "[internal] disabled"
      task default_task do
        puts "[internal] disabled: #{default_task}"
        # disabled
      end
    end
  end

  namespace :pending do
    [ :default, :diff ].each do |default_task|
      desc "[internal] disabled"
      task default_task do
        puts "[internal] disabled: #{default_task}"
        # disabled
      end
    end
  end
end

