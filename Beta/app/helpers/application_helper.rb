module ApplicationHelper

	def online_status(user)
		content_tag :span, user.name_else_email, class: "user-#{user.id} online_status #{'online' if user.online?}"
	end

	def notification_icon(notification)
		text = notification.content
		case
		when text.include?("ファイル")
			'paper-clip-2-24.png'
		when text.include?("メッセージ")
			'message-2-24.png'
		when text.include?("アクセス権限")
			'lock-unlocked-24.png'
		when text.include?("招待されました")
			'add-user-3-24.png'
		else
		end
	end

	def readmark_count(message)
		readmarks = Readmark.where(message_id: message.id, read: true)
		readmarks.count
	end

	def readmark_list(message)
		readmarks = Readmark.where(message_id: message.id, read: true)
		readmarks.map{ |readmark| readmark.user.username }.join(',')
	end

	def document_name(document)
		document.name.present? ? document.name : document.attachment.file.filename
	end

end
