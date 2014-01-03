require 'spec_helper'

describe Post do
  it 'is valid with a title, content, user_id, link, and link_url' do
    post = create(:post)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    expect(Post.new(title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without a user_id' do
    expect(Post.new(user_id: nil)).to have(1).errors_on(:user_id)
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
end
