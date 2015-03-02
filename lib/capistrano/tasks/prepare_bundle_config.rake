desc "Create bundle config"
task :prepare_bundle_config do
  on roles(:app) do
    within release_path do
      execute :bundle, 'config build.pg --with-pg_config=/usr/pgsql-9.4/bin/pg_config --local'
    end
  end
end
