module SessionHelper
  def log_in user
    session[:user_id] = user.id
  end

  def logged_in?
    session[:user_id].present?
  end
end
