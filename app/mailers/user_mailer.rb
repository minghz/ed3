class UserMailer < ActionMailer::Base
  default from: "app2986375@heroku.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Ed3 Password Reset"
  end

end
