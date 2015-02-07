set :output, "log/publisher.log"

every 1.hour, :roles => [:app] do
  rake "posts:publish_drafts"
end
