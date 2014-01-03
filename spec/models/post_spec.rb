require 'spec_helper'

describe Post do
  it 'is valid with a title, content, user_id, link, and link_url' do
    post = create(:post)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    expect(Post.new(title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without content' do
    pending("Post model needs validations")
    expect(Post.new(content: nil)).to have(1).errors_on(:content)
  end

  it 'is invalid without a user_id' do
    pending("Post model needs validations")
    expect(Post.new(user_id: nil)).to have(1).errors_on(:user_id)
  end

  context 'link is true' do
    it 'is invalid without a link_url' do
      pending("Post model needs validations")
      expect(Post.new(link_url: nil)).to have(1).errors_on(:link_url)
    end
  end
end
