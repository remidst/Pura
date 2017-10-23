class ConversationsChannel < ApplicationCable::Channel

	def subscribed
		stream_from("conversations_channel")
	end

	def unsubscribed
		#any cleanup needed when channel is unsubscribed
	end

	def send_message(data)
		conversation = Conversation.find_by(id: data['conversation_id'])
		if conversation && conversation.users.include?(current_user)
		    current_user.messages.create!(content: data['message'], conversation_id: data['conversation_id'])
		end
	end

end