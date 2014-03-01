atom_feed do |feed|
	feed.title "WesHargrove.com"
	feed.updated @posts.maximum(:updated_at)

	@posts.each do |post|
		feed.entry post, published: post.published_at do |entry|
			entry.title post.title
			entry.content RedCloth.new(post.content).to_html, type: 'html'
			entry.author do |author|
				author.name User.find(post.user_id).first_name + " " + User.find(post.user_id).last_name				
			end			
		end
	end
end
