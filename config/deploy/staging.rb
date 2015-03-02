set :stage, :staging

server '45.56.66.154', user: 'blog', roles: %w{web app db}

# SSH Options
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa.pub),
  forward_agent: true,
  auth_methods: %w(publickey)
}

fetch(:default_env).merge!(rails_env: :production)
