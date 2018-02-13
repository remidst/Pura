class TimelinesController < ApplicationController

	def index
		all_reporting_readmarks = current_user.reporting_readmarks.where(user_id: current_user.id, read: false)
		reporting_readmarks = all_reporting_readmarks.select{|readmark| readmark.reporting.confirmed }

		publication_readmarks = current_user.publication_readmarks.where(read: false)
		publication_comment_readmarks = current_user.publication_comment_readmarks.where(read: false)
		unpublished_reportings = Reporting.where(confirmed: false, publisher_id: current_user.id)

		@readmarks = reporting_readmarks + publication_readmarks + publication_comment_readmarks + unpublished_reportings

		if reporting_readmarks.present? || publication_readmarks.present? || publication_comment_readmarks.present? || unpublished_reportings.present?
			# mettre dans l'ordre
			publications_from_publications = publication_readmarks.map { |readmark| readmark.publication } 
			publications_from_comments = publication_comment_readmarks.map { |readmark| readmark.publication_comment.publication } 

			@publications = (publications_from_publications + publications_from_comments).uniq

			reportings_from_readmarks = reporting_readmarks.map { |readmarks| readmarks.reporting }

			@reportings = (unpublished_reportings + reportings_from_readmarks).uniq

			timelines = @publications + @reportings
			@timelines = timelines.sort_by(&:created_at).reverse

			@count = @timelines.count

			puts "timelines debug"
			puts @timelines.map {|timeline| timeline.class.name}
		else
			#modifier plus tard

			@reportings = current_user.reporting_readmarks.last(15).map {|readmark| readmark.reporting }
			@reportings.select!{|reporting| reporting.confirmed }
			@publications = current_user.publication_readmarks.last(15).map {|readmark| readmark.publication}

			timelines = @reportings + @publications

			@timelines = timelines.sort_by(&:created_at).reverse

			@count = 0

		end


	end

end
