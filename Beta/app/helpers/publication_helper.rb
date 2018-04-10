module PublicationHelper

	def publication_header(publication)

		if publication.publication_comments.present?
			last_comment = publication.publication_comments.last
				if last_comment.publisher == current_user
					"ご自身が書いたコメント"
				else
					"#{last_comment.publisher.username}がコメントを書きました"
				end
		else
			"#{publication.publisher.username} > #{publication.project.project_name.delete("　")}様の案件"
		end
	end

	def publication_second_header(publication)
		"#{publication.publisher.username} > #{publication.project.project_name.delete("　")}様の案件"
	end
end
