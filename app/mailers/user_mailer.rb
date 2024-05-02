class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = user
    @greeting = "Hi"
    mail to: user.email, subject: 'Reset password instructions'
  end
end
