$(document).ready ->
  messages = $('#message-list')
  if $('#message-list').length > 0

    App.conversation = App.cable.subscriptions.create {
        channel: "ConversationsChannel"
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        $('div#messages-' + data['conversation_id']).append data['message']

      send_message: (message, conversation_id) ->
        @perform 'send_message', message: message, conversation_id: conversation_id

    window.conversationid = 297

    $('textarea.textarea-id').click ->
      raw_id=$(this).attr('id')
      conversationid=raw_id.replace(/[^0-9]/g, '')

    $('.send-message-button').click ->
      alert(conversationid)

    $('#' + conversationid + '_new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#' + conversationid + '_message_content')
      if $.trim(textarea.val()).length > 1
        App.conversation.send_message textarea.val(), conversationid
        textarea.val('')
      e.preventDefault()
      return false