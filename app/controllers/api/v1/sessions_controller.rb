class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      render json: UserSerializer.new(user), status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    reset_session  
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
