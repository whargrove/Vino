class SessionsController < ApplicationController
  layout 'login'
  force_ssl except: :destroy, if: :ssl_configured?

  def new
    if current_user.nil?
      render 'new'
    else
      redirect_to admin_posts_path
    end
  end

  def create
    user = User.find_by_user_name(params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_posts_path
    else
      redirect_to login_url, alert: "User name or password is invalid"
    end
  end

  def destroy
    if current_user
      session[:user_id] = nil
      redirect_to root_url, notice: "Logged out"
    else
      redirect_to login_url
    end
  end

private

  def ssl_configured?
    # SSL is only configured for production environment
    Rails.env.production?
  end

end
