namespace :deploy do

  desc 'Create release.txt file in public directory'
  task :create_release_file do
    on roles(:app) do
      execute %{echo "#{revision_log_message}" > #{release_path.join('public/release.txt')}}
    end
  end
end
