class UsersController < ApplicationController

	def index
		@users=User.where(deleted_at: nil).where.not(email: current_user.email, username: [nil, ""]).order(:username)
		respond_to do |format|
			format.html
			format.json { render json: @users.where("UPPER(REPLACE(username, ' ','')) like UPPER(?)", "%#{params[:q]}%") }
		end
	end


end