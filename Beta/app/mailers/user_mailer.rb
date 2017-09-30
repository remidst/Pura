class UserMailer < ApplicationMailer

	def welcome(user)
		@user = user

		mail to: @user.email, subject: "#{@user.username}様、プラプラへようこそ！"
	end
end
