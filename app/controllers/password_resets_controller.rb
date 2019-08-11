class PasswordResetsController < ApplicationController
  before_action :get_and_validate_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    @user.create_reset_digest if @user

    flash[:info] = "Check your email for instructions how to reset your password"
    redirect_to root_url
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can not be empty")
      render :edit
    elsif @user.update_attributes(user_params)
      login @user
      @user.update_attribute(:password_reset_digest, nil)
      flash[:success] = "Your password has now been reset"
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_and_validate_user
    @user = User.find_by(email: params[:email])
    redirect_to root_path unless @user && BCrypt::Password.new(@user.password_reset_digest).is_password?(params[:id])
  end

  def check_expiration
    if @user.is_password_reset_expired?
      flash[:danger] = "Unfortunately your password reset link has expired"
      redirect_to new_password_reset_path
    end
  end
end