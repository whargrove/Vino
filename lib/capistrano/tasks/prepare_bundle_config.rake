desc "Create bundle config"
task :prepare_bundle_config do
  on roles(:app) do
    within release_path do
      execute :bundle, 'config build.pg --with-pg-config=/path/to/pg_config'
    end
  end
end
