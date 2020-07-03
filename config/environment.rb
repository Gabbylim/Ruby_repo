# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = 
  {
    :username => 'chattboxKE',
    :api_key  => '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',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }
