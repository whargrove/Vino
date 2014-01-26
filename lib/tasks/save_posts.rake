require 'rake'
namespace :posts do
  desc "Save all posts"
  task :save => :environment do
    puts "--- Saving posts ---"
    Post.find_each(&:save)
    puts "All posts have been saved.\n"
  end
end
