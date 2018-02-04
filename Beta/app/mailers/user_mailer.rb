class UserMailer < ApplicationMailer


	def welcome(user)
		@user = user

		mail to: @user.email, subject: "#{@user.username}様、コリブリへようこそ！" unless @user.deleted? || @user.unregistered?
	end

	def morning_notification_email(user)
		@user = user
		@reporting_readmarks = @user.reporting_readmarks.where(read: false)
		@publication_readmarks = @user.publication_readmarks.where(read: false)
		@publication_comment_readmarks = @user.publication_comment_readmarks.where(read: false)

		reportings = @reporting_readmarks.map {|mark| mark.reporting}
		publication_from_readmarks = @publication_readmarks.map {|mark| mark.publication }
		publication_from_comments = @publication_comment_readmarks.map {|mark| mark.publication}
		publications = (publication_from_comments + publication_from_readmarks).uniq
		@timelines = publications + reportings

		mail to: @user.email, subject: "#{@user.username}様、新規メッセージが届いております。" unless @user.deleted? || @user.unregistered?
	end


end
