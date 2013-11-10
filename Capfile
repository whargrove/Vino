# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include rbenv tasks 
# require 'capistrano/rbenv'

# set :rbenv_type, :user
# set :rbenv_ruby, '2.0.0-p247'

# Include bundler tasks
require 'capistrano/bundler'

# Include rails tasks
require 'capistrano/rails'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
