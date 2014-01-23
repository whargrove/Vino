class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  def index
    if current_user
      # Get the 5 most recent posts
      @posts = Post.order('created_at DESC').limit(5)
    else
      # Get the 5 most recent posts that are published
      @posts = Post.order('created_at DESC').where({ published: true }).limit(5)
    end

    # Set the time zone
    Time.zone = 'Pacific Time (US & Canada)'
  end

  # GET /posts/:id
  def show
    if current_user
      # Go ahead
      render 'show'
    elsif !current_user && @post.draft?
      # Redirect to /
      # beacuse visitors should not view drafts
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
