class PublicationsController < ApplicationController

	def create
		project = Project.find(params[:project_id])
		publication = project.publications.new(publication_params)
		publication.publisher_id = current_user.id

		respond_to do |format|
			if publication.save
				params[:publication_attachments]['attachment'].each do |a|
					publication_attachment = publication.publication_attachments.create!(attachment: a)
				end

				#room for other actions or callbacks

				format.html {redirect_to project, notice: 'メッセージが共有されました'}
			else
				format.html {render action: 'new'}
			end
		end
	end

	private

	def publication_params
		params.require(:publication).permit(:message, publication_attachments_attributes: [:id, :publication_id, :attachment])
	end
end
