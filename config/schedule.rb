set :output, "/log/publisher.log"

every 1.hours do
  rake "posts:publish_draft"
end
