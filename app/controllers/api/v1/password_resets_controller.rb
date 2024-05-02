class Api::V1::PasswordResetsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_token!
      UserMailer.reset_password_email(user).deliver_later
      render json: { message: "Email sent with password reset instructions" }, status: :ok
    else
      render json: { error: "Email address not found" }, status: :not_found
    end
  end

  def update
    user = User.find_by(reset_password_token: params[:token], email: params[:email])
    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password], params[:password_confirmation])
        render json: { message: "Password has been reset successfully." }, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Password token is invalid or has expired" }, status: :not_found
    end
  end
end
