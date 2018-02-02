class PublicationsController < ApplicationController

	def create
		project = Project.find(params[:project_id])
		publication = project.publications.new(publication_params)
		publication.publisher_id = current_user.id

		respond_to do |format|
			if publication.save

				#saves all the attachments to publications
				if params[:publication_attachments].present?
					params[:publication_attachments]['attachment'].each do |a|
						publication_attachment = publication.publication_attachments.create!(attachment: a)
					end
				end


				format.html {redirect_to project, notice: 'メッセージが共有されました'}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def toggle_read_publication
		@publication = Publication.find(params[:id])
		@readmark = @publication.publication_readmarks.where(user_id: current_user.id).take

		@readmark.toggle!(:read)

		if @publication.publication_comments.present?
			@publication.publication_comments.each do |publication_comment|
				comment_readmark = publication_comment.publication_comment_readmarks.where(user_id: current_user.id)
				comment_readmark.publication_comment_read!
			end
		end
	end

	def destroy
		@project = Project.find(params[:project_id])
		@publication = Publication.find(params[:id])

		respond_to do |format|
			if @publication.destroy
				format.html { redirect_to @project, notice: 'メッセージと添付ファイルが削除されました。'}
				format.json { head :no_content }
			else
				format.html { redirect_to @project, notice: 'メッセージと添付ファイルの削除が失敗しました' }
			end
		end
	end


	private

	def publication_params
		params.require(:publication).permit(:message, publication_attachments_attributes: [:id, :publication_id, :attachment])
	end
end
