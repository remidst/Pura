$(document).ready ->
	messages = $('#message-list')
	if $('#message-list').length > 0
		messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

		messages_to_bottom()

	App.global_conversation = App.cable.subscriptions.create {
		channel: "ConversationsChannel"
		conversation_id: $('.conversation-messages').data('conversation-id')
	},

		connected: ->
		# Called when the subscription is ready for use on the server

		disconnected: ->
		# Called when the subscription has been terminated by the server

		received: (data) ->
			$('div#messages-' + data['conversation-id']).append data['message']
			messages_to_bottom()

		send_message: (message, conversation_id) ->
		@perform 'send_message', message: message, conversation_id: conversation_id

		$('input.send-message-button-container').click ->
			$this = $(this)
			conversationid = $this.attr('id')
			selector = 'textarea#' + conversationid + '_message_content'
			textarea = $(selector)
			if $.trim(textarea.val()).length > 1
				App.global_conversation.send_message textarea.val(), conversationid
				textarea.val('')
			e.preventDefault()
			return false

