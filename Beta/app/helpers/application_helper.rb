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

	def gender(spec)

		if spec.present?
			gender = spec.gender
			gender == true ? '男' : '女'
		end
	end

	def home_owner(spec)
		if spec.present?
			ownership = spec.home_is_owner
			ownership == true ? "自宅" : "借家"
		end
	end

	def home_house(spec)
		if spec.present?
			house = spec.home_is_house
			house == true ? "一戸建て" : "集合住宅"
		end
	end

	def has_room(spec)
		if spec.present?
			room = spec.home_has_room
			room == true ? "自室有" : "自室無"
		end
	end

	def has_stairs(spec)
		if spec.present?
			stairs = spec.home_has_stairs
			stairs == true ? "階段あり" : "階段無し"
		end
	end

end
