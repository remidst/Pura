class MessageBroadcastJob < ApplicationJob

	queue_as :default

	def perform(message)
		ActionCable.server.broadcast "conversations_#{message.conversation.id}_channel", {message: render_message(message), conversation_id: message.conversation_id}		
	end

	private

	def render_message(message)
		MessagesController.render_with_signed_in_user(message.user, partial: 'messages/message', locals: {msg: message, conversation: message.conversation, project: message.conversation.project})
	end

end
