if Rails.env.development? 
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
		address: 'smtp.gmail.com',
		port: '587',
		authentication: :plain,
		user_name: 'kellybloc',
		password: 'secret',
		domain: 'heroku.com',
		enable_starttls_auto: true
	}
end

ActionMailer::Base.default_url_options[:host] = 'localhost:3000'