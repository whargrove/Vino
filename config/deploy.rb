set :application, 'blog'
set :repo_url, 'git@github.com:whargrove/Vino.git'
set :branch, 'master'
set :deploy_to, "/var/www/#{fetch(:application)}"
set :scm, :git
set :format, :pretty
set :log_level, :info
set :pty, true
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :ping_url, "http://www.weshargrove.com/ping"
set :rbenv_type, :user
set :rbenv_ruby, '2.2.0'
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :keep_releases, 5

# bundler
set :bundle_jobs, 4
set :bundle_flags, '--deployment'

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

  desc 'Create releast.txt file in public directory'
  task :create_release_file do
    on roles(:app) do
      execute %{echo "#{revision_log_message}" > #{release_path.join('public/release.txt')}}
    end
  end

  after :finishing, 'deploy:ping'
  after :finishing, 'deploy:cleanup'
  after :finished, 'deploy:create_release_file'

end
