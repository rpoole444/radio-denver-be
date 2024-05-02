class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_password_token!
      UserMailer.reset_password_email(@user).deliver_later
      flash[:notice] = "Email sent with password reset instructions."
    else
      flash.now[:alert] = "Email address not found."
      render :new
    end
  end

  def edit
    @user = User.find_by(reset_password_token: params[:token], email: params[:email])
  end

  def update
    @user = User.find_by(reset_password_token: params[:token], email: params[:email])
    if @user.reset_password!(params[:user][:password], params[:user][:password_confirmation])
      flash[:notice] = "Password has been reset."
    else
      render :edit
    end
  end
end
