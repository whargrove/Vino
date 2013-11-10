set :application, 'blog'
set :repo_url, 'git@github.com:whargrove/Vino.git'
set :branch, 'cap3'
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
      run "/etc/inid.d/unicorn_#{fetch(:application)} restart"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

  after :finishing, 'deploy:cleanup'

end
