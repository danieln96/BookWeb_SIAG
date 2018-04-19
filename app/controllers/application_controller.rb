class ApplicationController < ActionController::Base
  before_action :check_session
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def logged_in?
    !!current_user
  end
  def check_session
    if session[:user_id]
      if (session[:expires_at] < Time.current)
        session[:user_id] = nil
        session[:expires_at] = nil
        flash[:info] = "Sesja wygasła. Zaloguj się ponownie..."
        redirect_to login_path
      else
        session[:expires_at] = Time.current + 20.minutes
      end
    end
  end
end
