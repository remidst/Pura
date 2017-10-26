$(document).on 'turbolinks:load', ->

  messages_to_bottom= -> 
    $(".conversation-messages").each ->
      $this = $(this)
      $this.scrollTop($this.prop("scrollHeight"))

  messages_to_bottom()

  layout: ->
    $(".message-container").each ->
      $this = $(this)
      if $this.data('sender') == current_user_id
        $this.find(".message-username").addClass("self")
        $this.find(".messages").addClass("message-sent")
        $this.find(".message-content").addClass("sent")
        return true

  App.conversation = App.cable.subscriptions.create {
      channel: "ConversationsChannel"
      conversation_id: $('.conversation-messages').data('conversation-id')
    },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      $('#messages-' + data['conversation_id']).append(data['message'])
      layout()
      messages_to_bottom()

    send_message: (message, conversation_id) ->
      @perform 'send_message', message: message, conversation_id: conversation_id

  window.conversationid = 1

  $('textarea.textarea-id').click ->
    raw_id=$(this).attr('id')
    conversationid=raw_id.replace(/[^0-9]/g, '')

    $('#' + conversationid + '_new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#' + conversationid + '_message_content')
      if $.trim(textarea.val()).length > 1
        App.conversation.send_message textarea.val(), conversationid
        textarea.val('')
      e.preventDefault()
      return false

$(document).on 'click', '#notification .close', ->
  $(this).parents('#notification').fadeOut(1000)