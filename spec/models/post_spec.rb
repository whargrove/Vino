require 'spec_helper'

describe Post, :type => :model do
  it 'is valid with a title, content, user_id, link, and link_url' do
    post = create(:post)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    expect(Post.new(title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid with a duplicate title' do
    first_post = create(:post)
    expect(Post.new(title: 'post')).to have(1).errors_on(:title)
  end

  it 'is invalid without a user_id' do
    expect(Post.new(user_id: nil)).to have(1).errors_on(:user_id)
  end

  it 'is invalid without published_at if scheduled' do
    post = create(:scheduled_post)
    post.published_at = nil
    expect(post).to_not be_valid
  end

  it 'is invalid without published_at if published' do
    post = create(:published_post)
    post.published_at = nil
    expect(post).to_not be_valid
  end

  context 'link is true' do
    it 'is invalid without a link_url' do
      expect(Post.new(link: true, link_url: nil)).to have(2).errors_on(:link_url)
      # Expects two errors because both validates_presence_of :link_url and validates :link_url_format_valid? fail
    end

    it 'is invalid with a malformed URL' do
      expect(Post.new(link: true, link_url: 'foo')).to have(1).errors_on(:link_url)
    end
  end

  context 'status is draft' do
    it 'is a draft' do
      post = Post.new(status: 0)
      expect(post.draft?).to be_truthy
    end
  end

  context 'status is scheduled' do
    it 'is scheduled to be published' do
      post = Post.new(status: 1, published_at: DateTime.now.utc + 1.hour)
      expect(post.scheduled?).to be_truthy
    end
  end

  context 'status is published' do
    it 'is is published' do
      post = Post.new(status: 2)
      expect(post.published?).to be_truthy
    end
  end
end
