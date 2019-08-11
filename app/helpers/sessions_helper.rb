module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] rescue nil
  end

  def is_logged_in?
    !current_user.nil?
  end

  def authenticate_user
    unless is_logged_in?
      flash[:danger] = "Please login first."
      redirect_to login_url
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end