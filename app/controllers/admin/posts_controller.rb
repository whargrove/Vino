class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:index, :new, :edit, :create, :update, :destroy]
  
  # GET admin/posts
  def index
    @posts = Post.order('created_at DESC')
    Time.zone = 'Pacific Time (US & Canada)'
  end

  # GET /posts/1
  def show
    render 'posts/show'
  end

  # GET admin/posts/new
  def new
    @post = Post.new
  end

  # GET admin/posts/:id/edit
  def edit
  end

  # POST admin/posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render action: 'new'
    end
  end

  # PATCH/PUT admin/posts/:id
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render action: 'edit'
    end
  end

  # DELETE admin/posts/:id
  def destroy
    @post.destroy
    redirect_to admin_posts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :link, :link_url)
    end
end
