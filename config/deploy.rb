set :application, 'blog'
set :repo_url, 'git@github.com:whargrove/Vino.git'
set :branch, 'master'
set :deploy_to, "/var/www/#{fetch(:application)}"
set :scm, :git
set :format, :pretty
set :log_level, :info
set :pty, true
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :ping_url, "http://weshargrove.com/ping"
set :rbenv_type, :user
set :rbenv_ruby_version, '2.0.0-p353'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  before :deploy, 'check_revision'
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Force restart of passenger after restart'
  task :ping do
  	system "curl --silent #{fetch(:ping_url)}"
  end

  after :finishing, 'deploy:ping'
  after :finishing, 'deploy:cleanup'

end
