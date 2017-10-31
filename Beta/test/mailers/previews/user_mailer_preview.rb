# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

	def welcome
		user = User.first
		UserMailer.welcome(user)
	end

	def morning_notification_email
		user = User.joins(:notifications).where(notifications: {read: false}).first
		UserMailer.morning_notification_email(user)
	end

end
