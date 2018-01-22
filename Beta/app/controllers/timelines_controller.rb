class TimelinesController < ApplicationController

	def index
		publication_readmarks = current_user.publication_readmarks
		reporting_readmarks = current_user.reporting_readmarks
		publication_comment_readmarks = current_user.publication_comment_readmarks
		
	end
end
