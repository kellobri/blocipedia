if Rails.env.development? 
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.default_url_options[:host] = 'localhost:3000'
	ActionMailer::Base.smtp_settings = {
    	address: "smtp.gmail.com",
    	port: 587,
    	domain: 'localhost:3000',
    	authentication: "plain",
    	enable_starttls_auto: true,
    	user_name: ENV['GMAIL_USERNAME_DEV'],
    	password: ENV['GMAIL_PASSWORD_DEV']
  	}
end
