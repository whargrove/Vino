class SessionsController < ApplicationController
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
  		flash.now.alert = "Email or password is invalid"
  		render 'new'
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
end
