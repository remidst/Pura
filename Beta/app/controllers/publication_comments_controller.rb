class PublicationCommentsController < ApplicationController

	def create
		@publication = Publication.find(params[:publication_id])
		@publication_comment = @publication.publication_comments.new(publication_comment_params)
		@publication_comment.publisher_id = current_user.id 

		respond_to do |format|
			if @publication_comment.save

				#save all the comment's attachments
				if params[:publication_comment_attachments].present?
					params[:publication_comment_attachments]['attachment'].each do |a|
						publication_comment_attachment = @publication_comment.publication_comment_attachments.create!(attachment: a)
					end
				end

				format.html { redirect_to @publication.project, notice: 'コメントが送られました。' }
				format.js
			else
				format.html { redirect_to @publication.project, notice: 'コメントは送られませんでした。' }
			end
		end
	end

	private

	def publication_comment_params
		params.require(:publication_comment).permit(:comment, publication_comment_attachments_attributes: [:id, :publication_comment_id, :attachment])
	end

end
