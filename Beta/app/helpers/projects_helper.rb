module ProjectsHelper

	def publication_readmark_count(publication)
		readmarks = PublicationReadmark.where(publication_id: publication.id, read: true)
		readmarks.count
	end

	def publication_readmark_list(publication)
		readmarks = PublicationReadmark.where(publication_id: publication.id, read: true)
		readmarks.map{ |readmark| readmark.user.username }.join(',')
	end

	def publication_comment_readmark_count(publication_comment)
		readmarks = PublicationCommentReadmark.where(publication_comment_id: publication_comment.id, read: true)
		readmarks.count
	end

	def age(spec)
	  dob = spec.birthday
	  
	  unless dob.nil?
	  	now = Time.now.utc.to_date
	  	now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	  end
	end
end
