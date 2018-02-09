class PublicationCommentAttachmentsController < ApplicationController

	def destroy
		@publication_comment = PublicationComment.find(params[:publication_comment_id])
		@publication_comment_attachment = PublicationCommentAttachment.find(params[:id])

		respond_to do |format|
			if @publication_comment_attachment.destroy
				format.js
			else
				format.html { redirect_to @publication_comment.publication.project, notice: 'ファイルの削除が失敗しました' }
			end
		end
	end

	private

end
