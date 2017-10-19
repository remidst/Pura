class ConversationsChannel < ApplicationCable::Channel

	def subscribed
		stream_from "conversation"
	end

	def unsubscribed
		#any cleanup needed when channel is unsubscribed
	end

	def send_message(data)
		current_user.messages.create!(content: data['message'], conversation_id: data['conversation_id'])
	end

end