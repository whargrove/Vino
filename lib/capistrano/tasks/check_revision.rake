desc "Ensure master is in sync with remote before deploying"
task :check_revision do
  on roles(:web) do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
      error "Local branch is not the same as origin/#{fetch(:branch)}"
      error "Run `git push` from local branch to sync changes"
      exit
    end
    info "Local branch is in sync with remote; proceeding with deploy."
  end
end
