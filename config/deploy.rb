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
set :rbenv_ruby, '2.0.0-p353'
set :keep_releases, 5

namespace :deploy do

  before :deploy, 'check_revision'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after 'deploy:publishing', 'deploy:restart'

  desc 'Force restart of passenger after restart'
  task :ping do
  	system "curl --silent #{fetch(:ping_url)}"
  end

  after :finishing, 'deploy:ping'
  after :finishing, 'deploy:cleanup'

end
