class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authenticate_user!
    redirect_to sign_in_path unless current_user
  end
  
  def is_student?
    !current_user.is_faculty
  end
  
  def is_faculty?
    current_user.is_faculty?
  end
end
