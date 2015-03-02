# This config is valid only for this version of Capistrano
lock '3.3.5'

# Application
set :application, 'blog'
set :repo_url, 'git@github.com:whargrove/vino.git'
set :keep_releases, 5
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Only deploy from the master branch
set :branch, 'master'

# Default deploy_to is /var/www/app_name
set :deploy_to, "/var/www/#{fetch(:application)}"

# Git!
set :scm, :git

# Pretty stdout
set :format, :pretty

# Set to :debug if you want a more verbose output
set :log_level, :info

# Rbenv
set :rbenv_type, :user
set :rbenv_ruby, '2.2.0'
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Bundler
set :bundle_jobs, 4
set :bundle_flags, '--deployment'

# Other
set :pty, true

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
  after :finished, :create_release_file

end
