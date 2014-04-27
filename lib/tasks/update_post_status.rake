require 'rake'
namespace :posts do
  desc "Update status for all posts"
  task :update_post_status => :environment do
    puts "--- Updating status ---"
    posts = Post.all
    posts.each do |p|
      if p.published_at && p.published_at.past?
        p.published!
        p.save!
      end
    end
    puts "All posts have been updated.\n"
  end
end
