desc "Heroku scheduler tasks"

task :email_morning_notification => :environment do
	puts "Sending email notifications every morning"
	User.morning_notification
	puts "emails are sent!"
end

task :email_noon_notification => :environment do
	puts "Sending email notifications every afternoon"
	User.morning_notification
	puts "emails are sent!"
end

task :email_afternoon_notification => :environment do
	puts "Sending email notifications every afternoon"
	User.morning_notification
	puts "emails are sent!"
end

task :test_production => :environment do
	puts "Sending email notification to remi.daste@keio.jp"
	User.test_scheduler
	puts "email sent"
end

task :auth_token => :environment do
	puts "adding authentication token to each user"
	User.add_token
	puts "tokens added"
end