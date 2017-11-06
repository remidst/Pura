class ConversationsChannel < ApplicationCable::Channel

	def subscribed
		stream_from "conversations_#{params['conversation_id']}_channel"
	end

	def unsubscribed
		#any cleanup needed when channel is unsubscribed
	end

	def send_message(data)
		conversation = Conversation.find_by(id: data['conversation_id'])
		if conversation && conversation.users.include?(current_user)
		    current_user.messages.create!(content: data['message'], conversation_id: data['conversation_id'])

		    #after creating the message, send notification to all other project users if they don't already have a notification
		    project = conversation.project
		    users = project.users.where.not(id: current_user.id)

		    users.each do |user|
			    unless notification_message_exists?(user, project)
				    notification = user.notifications.create(project_id: project.id, read: false)
				    notification.new_message!
				end
			end

			#after sending a message, make sure that all the previous messages are marked as read
			unread_messages = conversation.messages.last(5)
			unread_messages.each do |msg|
				readmark = Readmark.where(user_id: current_user.id, read: false, message_id: msg.id)
        		readmark.message_read! if readmark.present?
			end
		end
	end

	private

	def notification_message_exists?(user, project)
		user.notifications.where(project_id: project.id, content: "新しいメッセージが共有されました。", read: false).present?
	end

end