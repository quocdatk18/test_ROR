class SessionsController < ApplicationController
  def new
    redirect_to books_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Login success"
      log_in user
      redirect_to '/books'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
