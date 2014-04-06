require 'rake'
namespace :posts do
  desc "Publish a scheduled draft"
  task :publish_drafts => :environment do
    posts = Post.where("published = false")
    posts.each do |p|
      if p.published_at && p.published_at <= Time.now.utc
        p.published = true
        p.save!
      end
    end
  end
end
