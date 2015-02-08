require 'rake'
namespace :posts do
  desc "Publish scheduled drafts"
  task :publish_drafts => :environment do
    puts "[#{Time.now.iso8601}] Starting posts:publish_drafts task"
    posts = Post.scheduled.all
    unless posts.empty?
      puts "[#{Time.now.iso8601}] Getting all scheduled posts"
      posts.each do |post|
        if p.published_at && p.published_at <= Time.now.utc
          puts "[#{Time.now.iso8601}] Found eligible post: #{post.id}"
          p.published!
          puts "[#{Time.now.iso8601}] Published #{post.id}"
          p.tweet
        end
      end
    else
      puts "[#{Time.now.iso8601}] No scheduled posts"
    end
  end
end
