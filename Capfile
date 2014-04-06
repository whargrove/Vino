# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include bundler tasks
require 'capistrano/bundler'

# Include rbenv tasks
require 'capistrano/rbenv'

# Include rails tasks
require 'capistrano/rails'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
