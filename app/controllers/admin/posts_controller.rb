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

    # Use hipsterjesus.com API to get placeholder text for posts/new text area >_>
    require 'net/http'
    uri = URI('http://hipsterjesus.com/api/')
    params = { :paras => 1, :type => 'hipster-centric', :html => false }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      @hipster_placeholder = JSON.parse(response.body)["text"]
    else
      @hipster_placeholder = nil
    end
  end

  # GET admin/posts/:id/edit
  def edit
  end

  # POST admin/posts
  def create
    @post = Post.new(post_params)

    # Save as draft or publish the post
    if params[:commit] == 'Save'
      @post.published = false
    elsif params[:commit] == 'Publish'
      @post.published_at = DateTime.now.utc
      @post.published = true
    end

    if @post.save
      redirect_to admin_posts_url, notice: "Post was created."
    else
      render action: 'new', error: "Something happened."
    end
  end

  # PATCH/PUT admin/posts/:id
  def update
    # Save as draft or publish the post
    if params[:commit] == 'Save'
      @post.published = false
    elsif params[:commit] == 'Publish'
      @post.published_at = DateTime.now.utc
      @post.published = true
    end

    if @post.update(post_params)
      redirect_to admin_posts_url, notice: "Post was updated."
    else
      render action: 'edit', error: "Something happened."
    end
  end

  # DELETE admin/posts/:id
  def destroy
    @post.destroy
    redirect_to admin_posts_url, notice: "Post was deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      # Use friendly_id to find @post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :link, :link_url, :published)
    end
end
