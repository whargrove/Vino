class UsersController < ApplicationController
  layout 'signup'
  before_action :authorize_registration
  force_ssl if: :ssl_configured?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_posts_url, notice: "Thank you for signing up!"
    else
      render 'new'
    end
  end

private
  def user_params
    params.require(:user).permit(:user_name, :first_name, :last_name, :password, :password_confirmation)
  end

  def ssl_configured?
    !Rails.env.development?
  end
end
