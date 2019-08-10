class UsersController < ApplicationController
  def edit
    # TODO: Secure this
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have been successfully registered!"
      redirect_to edit_user_path(@user)
    else
      render :new
    end
  end

  def update
    # TODO: Secure this
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been successfully updated"
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end