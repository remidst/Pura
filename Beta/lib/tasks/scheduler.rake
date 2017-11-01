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