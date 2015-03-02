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
set :rbenv_type, :user
set :rbenv_ruby, '2.2.0'
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :keep_releases, 5

# bundler
set :bundle_jobs, 4
set :bundle_flags, '--deployment'

namespace :deploy do

  before :deploy, :check_revision

  # Task to trigger Unicorn restart
  %w[start stop restart].each do |command|
    desc "#{command} Unicorn server"
    task command do
      on roles(:app) do
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command} #{fetch(:rails_env)}"
      end
    end
  end

  # Restart Unicorn on deploy and rollback
  after :deploy, 'deploy:restart'
  after :rollback, 'deploy:restart'

  after :finishing, 'deploy:cleanup'
  # after :finished, :create_release_file

end
