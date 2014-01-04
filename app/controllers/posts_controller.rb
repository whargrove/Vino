class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  
  # GET /posts
  def index
    @posts = Post.order('created_at DESC').limit(5)
    Time.zone = 'Pacific Time (US & Canada)'

    if Rails.env.production? && current_user.nil?
      StatHat::API.ez_post_count("Blog Page View", CONFIG[:stathat_ez_api_key], 1)
    end
  end

  # GET /posts/:id
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
