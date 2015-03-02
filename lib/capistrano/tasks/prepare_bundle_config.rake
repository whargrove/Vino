desc "Create bundle config"
task :prepare_bundle_config do
  on roles(:app) do
    within release_path do
      execute 'bundle config --local build.pg --with-pg-config=/usr/pgsql-9.4/bin/pg_config'
    end
  end
end
