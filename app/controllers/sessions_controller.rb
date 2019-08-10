class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to edit_user_path(user)
    else
      flash.now[:danger] = 'Please check your username and password.'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
