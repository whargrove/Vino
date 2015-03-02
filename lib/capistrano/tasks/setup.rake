namespace :setup do

  desc 'Upload /config/*.yml files'
  task :upload_ymls do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      ymls = %w[database secrets]
      ymls.each do |file|
        upload! StringIO.new(File.read("config/#{file}.yml")), "#{shared_path}/config/#{file}.yml"
      end
    end
  end

  desc 'Symlink config files for nginx and Unicorn'
  task :symlink_configs_and_init do
    on roles(:app) do

      # nginx
      ## remove existing nginx confs
      execute 'rm -f /etc/nginx/conf.d/*'
      ## symlink nginx.conf to /etc/nginx/conf.d
      execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/conf.d/#{fetch(:application)}.conf"

      # Unicorn
      ## symlink unicorn init to /etc/init.d
      execute "ln -nfs #{current_path}/config/unicorn.sh /etc/init.d/unicorn_#{fetch(:application)}"
    end
  end
end
