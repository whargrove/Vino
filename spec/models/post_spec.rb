require 'spec_helper'

describe Post do
  it "has no posts in the database" do
    expect(Post).to have(:no).records
    expect(Post).to have(0).records
  end

  it "has one record" do
    post = create(:post)
    expect(Post.where(:title => 'post')).to have(1).record
  end

  it "counts only records that match a query" do
    post = create(:post)
    expect(Post.where(:title => 'post')).to have(1).record
    expect(Post.where(:title => 'post_foo')).to have(0).record
  end
end
