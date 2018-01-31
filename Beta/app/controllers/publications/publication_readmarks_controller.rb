class Publications::PublicationReadmarksController < ApplicationController

	before_action :load_publication

	def update
		@publication_readmark = @publication.publication_readmarks.where(user_id: current_user.id)

		if @publication_readmark.read
			@publication_readmark.update!(read: false)
		else
			@publication_readmark.update!(read: true)
		end
	end

	private

	def load_publication
		@publication = Publication.find(params[:publication_id])
	end
end