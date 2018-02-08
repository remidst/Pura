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
	puts "should be removed"
end

task :add_documentships => :environment do
	puts "adding join record for previous documents"
	Document.add_user
	puts "documentships added"
	puts "should be removed"
end

task :add_specs => :environment do
	puts "adding blank specs to previous projects"
	Project.specs_adder_temp
	puts "specs added"
end

task :add_contacts => :environment do
	puts "adding contacts"
	Project.contacts_adder_temp
	puts "contacts added"
end

task :create_timelines => :environment do 
	puts "creating timelines"
	User.add_timeline
	puts "timelines added"
end

task :add_confirmed_to_reportings => :environment do 
	puts "creating confirmed status for previous reportings"
	Reporting.add_confirmed
	puts "added confirmed"
end
