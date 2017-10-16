class MessageBroadcastJob < ApplicationJob

	queue_as :default

	def perform(message)
		ActionCable.server.broadcast "conversations_#{message.conversation.id}_channel", message: render_message(message)
	end

	private

	def render_message(message)
		MessagesController.render partial: 'messages/list', locals: {msg: message}
	end

end
