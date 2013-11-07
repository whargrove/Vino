class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
  	redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
  
  def authorize_registration
    if Rails.env.production?
      if request.remote_ip == CONFIG[:ip_address]
        return true 
      else
        redirect_to root_url, alert: "Not authorized"
      end
    elsif Rails.env.development?
      return true
    else
      redirect_to root_url, alert: "Not authorized" if Rails.env.production?
    end
  end
end
