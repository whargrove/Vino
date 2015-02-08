require 'rake'
namespace :posts do
  desc "Publish scheduled drafts"
  task :publish_drafts => :environment do
    puts "[#{Time.now.iso8601}] Getting all scheduled posts"
    Post.scheduled.all.each do |post|
      if p.published_at && p.published_at <= Time.now.utc
        puts "[#{Time.now.iso8601}] Found eligible post: #{post.id}"
        p.published!
        puts "[#{Time.now.iso8601}] Published #{post.id}"
        p.tweet
      end
    end
  end
end
