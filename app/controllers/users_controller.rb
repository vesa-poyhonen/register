class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new, :create]

  def edit
    return redirect_to edit_user_path(current_user) if current_user.id.to_i != params[:id].to_i

    @user = User.find(current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have been successfully registered! Your username is #{@user.username}."
      login @user
      redirect_to edit_user_path(@user)
    else
      render :new
    end
  end

  def update
    return redirect_to edit_user_path(current_user) if current_user.id.to_i != params[:id].to_i

    @user = User.find(current_user.id)
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