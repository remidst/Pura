module PublicationHelper

	def publication_header(publication)
		if publication.publication_comments.present?
			last_comment = publication.publication_comments.last
				if last_comment.publisher == current_user
					if publication.publisher == current_user
						"#{publication.project.project_name.gsub(/\s+/, '')}様の案件に書いたコメント"
					else
						"#{publication.project.project_name.gsub(/\s+/, '')}様の案件の#{publication.publisher.username}様のメッセージに書いたコメント"
					end
				else
					if publication.publisher == current_user
						"#{last_comment.publisher.username}様が#{publication.project.project_name.gsub(/\s+/, '')}様の案件のメッセージにコメントを書きました"
					else
						"#{last_comment.publisher.username}様が#{publication.project.project_name.gsub(/\s+/, '')}様の案件のメッセージにコメントを書きました"
					end
				end
		else
			# no comments on this publication
			if publication.publisher == current_user
				"#{publication.project.project_name.gsub(/\s+/, '')}様の案件に共有したメッセージ"
			else
				"#{publication.publisher.username}様が#{publication.project.project_name.gsub(/\s+/, '')}様の案件にメッセージを共有しました"
			end
		end
	end
end
