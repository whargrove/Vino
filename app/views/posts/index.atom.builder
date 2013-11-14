atom_feed do |feed|
	feed.title "WesHargrove.com"
	feed.updated @posts.maximum(:updated_at)

	@posts.each do |post|
		feed.entry post, published: post.created_at do |entry|
			entry.title post.title
			entry.content post.content
			entry.author do |author|
				author.name User.find(post.user_id).first_name + " " + User.find(post.user_id).last_name				
			end			
		end
	end
end
