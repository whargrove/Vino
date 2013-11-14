class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  
  # GET /posts
  def index
    @posts = Post.order('created_at DESC').limit(5)
    Time.zone = 'Pacific Time (US & Canada)'
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
