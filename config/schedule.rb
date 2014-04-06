set :output, "log/publisher.log"

every 1.hour do
  rake "posts:publish_drafts"
end
