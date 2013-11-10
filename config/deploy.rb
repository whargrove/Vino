set :application, 'blog'
set :repo_url, 'git@github.com:whargrove/Vino.git'
set :branch, 'master'
set :deploy_to, "/var/www/#{fetch(:application)}"
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml config/application.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  before :deploy, 'check_revision'
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # run "/etc/inid.d/unicorn_#{fetch(:application)} restart"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'

end
