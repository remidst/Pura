class MessageBroadcastJob < ApplicationJob

	queue_as :default

	def perform(message)
		message_rendered = render_message(message)
		ActionCable.server.broadcast "conversations_channel", {message: message_rendered, conversation_id: message.conversation_id, notification: render_notification(message)}		
	end

	private

	def render_notification(message)
		NotificationsController.render_with_signed_in_user(message.user, partial: 'notifications/notification', locals: {message: message})
	end

	def render_message(message)
		MessagesController.render_with_signed_in_user(message.user, partial: 'messages/message', locals: {msg: message, conversation: message.conversation, project: message.conversation.project})
	end

end
