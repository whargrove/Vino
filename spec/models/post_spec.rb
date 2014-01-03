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
      expect(Post.new(link: true, link_url: nil)).to have(1).errors_on(:link_url)
    end
  end
end
