desc "Heroku scheduler tasks"
task :email_morning_notification => :environment do
	puts "Sending email notifications every morning"
	User.morning_notification
	puts "emails are sent!"
end
