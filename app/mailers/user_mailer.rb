class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = user
    @url = 'link_to_frontend_reset_page' # Frontend URL where the user can enter a new password
    mail(to: @user.email, subject: 'Reset password instructions')
  end
end
