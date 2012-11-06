# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ed3::Application.initialize!

#Configuring mailing smtp
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "gmail.com",
  :user_name => ENV['GMAIL_SMTP_USER'],
  :password => ENV['GMAIL_SMTP_PASSWORD'],
  :authentication => 'plain'
}
#config.action_mailer.raise_delivery_errors = true

# Configuration for using SendGrid on Heroku
#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.smtp_settings = {
#  :user_name      => ENV['SENDGRID_USERNAME'],
#  :password       => ENV['SENDGRID_PASSWORD'],
#  :domain => "heroku.com",
#  :address => "smtp.sendgrid.net",
#  :port => 587,
#  :authentication => :plain,
#  :enable_starttls_auto => true
#}

