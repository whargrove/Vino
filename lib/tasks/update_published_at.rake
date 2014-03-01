require 'rake'
namespace :posts do
  desc "Update published_at for all posts"
  task :update_published_at => :environment do
    puts "--- Updating published_at ---"
    posts = Post.all
    posts.each do |p|
      p.published_at = p.created_at
      p.save!
    end
    puts "All posts have been updated.\n"
  end
end
