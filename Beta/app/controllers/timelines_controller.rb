class TimelinesController < ApplicationController

	def index
		reporting_readmarks = current_user.reporting_readmarks.where(read: false)
		publication_readmarks = current_user.publication_readmarks.where(read: false)
		publication_comment_readmarks = current_user.publication_comment_readmarks.where(read: false)

		if reporting_readmarks.present? || publication_readmarks.present? || publication_comment_readmarks.present?
			# mettre dans l'ordre
			publications_from_publications = publication_readmarks.map { |readmark| readmark.publication } 
			publications_from_comments = publication_comment_readmarks.map { |readmark| readmark.publication_comment.publication } 

			@publications = (publications_from_publications + publications_from_comments).uniq

			@reportings = reporting_readmarks.map { |readmarks| readmarks.reporting }

			@timeline = @publications + @reportings
			@timeline.sort_by(&:created_at)
		else
			#rien dans le timeline, ou les 20-30 derniers
			@reportings = current_user.reporting_readmarks.last(5).map {|readmark| readmark.reporting }
			@publications = current_user.publication_readmarks.last(5).map {|readmark| readmark.publication}
		end


	end

end
