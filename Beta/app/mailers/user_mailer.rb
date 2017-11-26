class UserMailer < ApplicationMailer


	def welcome(user)
		@user = user

		mail to: @user.email, subject: "#{@user.username}様、コリブリへようこそ！" unless @user.deleted? || @user.unregistered?
	end

	def morning_notification_email(user)
		@user = user
		@notifications = user.notifications.where(read: false)

		mail to: @user.email, subject: "#{@user.username}様、新規メッセージが届いております。" unless @user.deleted? || @user.unregistered?
	end


end
