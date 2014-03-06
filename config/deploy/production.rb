set :stage, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'pm25-inquiry.info', user: 'ec2-user', roles: [:app], ssh_options: {
    keys: [File.join(ENV["HOME"], '.ssh', 'credential.pem')]
}

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

# fetch(:default_env).merge!(rails_env: :production)

before 'deploy:check', 'production:change_directory_permission'
after 'deploy:updated', 'production:check_configuration'
after 'deploy', 'production:auto_start_apache'

namespace :deploy do
  task :restart do
    on roles(:app) do
      sudo '/etc/init.d/httpd restart'
    end
  end

  task :start do
    on roles(:app) do
      sudo '/etc/init.d/httpd start'
    end
  end

end

namespace :production do
  task :change_directory_permission do
    on roles(:app) do
      sudo "chgrp ec2-user /var/www"
      sudo "chmod 775 /var/www"
      sudo "chown -R ec2-user /var/www/*"
    end
  end

  task :check_configuration do
    on roles(:app) do
      sudo "ln -fs #{deploy_to}/current/config/deploy/passenger.conf /etc/httpd/conf.d/passenger.conf"
    end
  end

  task :auto_start_apache do
    on roles(:app) do
      sudo "/sbin/chkconfig --level 2345 httpd on"
    end
  end
end

namespace :update_city_ranking do
  task :start do
    on roles(:app) do
      execute "cd #{deploy_to}/current/update_city_ranking; nohup rackup -p 4567 &"
      execute "echo 'update city ranking scheduler started'"
    end
  end

  task :stop do
    on roles(:app) do
      execute "cd #{deploy_to}/current/update_city_ranking; sh ./stop_scheduler.sh"
      execute "echo 'update city ranking scheduler stopped'"
    end
  end
end

namespace :db do
  task :dump_db do
    on roles (:app) do
      execute "echo 'upload dumped mongodb to s3'"
      execute 'ruby db_upload.rb'
    end
  end
end