class UserMailer < ApplicationMailer
  default from: "railstest@test.com"
 
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Welcome to our app"
  end
end
