class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:index, :new, :edit, :create, :update, :destroy]
  layout 'admin'

  # GET admin/posts
  def index
    @posts = Post.order('published_at DESC')
    Time.zone = 'Pacific Time (US & Canada)'
  end

  # GET /posts/1
  def show
    render 'posts/show'
  end

  # GET admin/posts/new
  def new
    @post = Post.new

    # Use hipsterjesus.com API to get placeholder text for posts/new text area ^_^
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
    set_status(post_params, @post)

    if @post.save
      if @post.published?
        @post.tweet
      end
      redirect_to admin_posts_url, notice: "Post was created."
    else
      render action: 'new', error: "Something happened."
    end
  end

  # PATCH/PUT admin/posts/:id
  def update
    if @post.update(set_status(post_params, @post))
      if @post.published?
        @post.published_at = Time.now.utc if @post.published_at.nil?
        @post.tweet
        @post.save!
      end
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

    # Set the status for the post
    def set_status(post_params, post)
      case params[:commit]
      when 'Save'
        if post_params['published_at'].empty?
          post.draft!
        else
          # Must set published_at here otherwise post validation will fail
          post.published_at = post_params['published_at']
          post.scheduled!
        end
      when 'Save & Publish'
        unless post_params['published_at'].empty?
          post_params['published_at'] = Time.now.utc
        else
          post.published_at = Time.now.utc
        end
        post.published!
      end
      return post_params
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :link, :link_url, :status, :published_at)
    end
end
