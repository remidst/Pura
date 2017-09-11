class MembershipsController < ApplicationController

	before_action :set_project

	def create
		@membership = @project.memberships.new(membership_params)
		@membership.project = @project

		if @membership.save
			redirect_to @project, notice: '新しいメンバーが招待されました。'
		else
			redirect_to @project, alert: 'メンバーの招待が失敗しました。'
	    end
    end

	def edit
	end

	def destroy
	end

	

	private

	def set_project
		@project = current_user.projects.find(params[:project_id])
	end
		
	def membership_params
		params.require(:membership).permit(:email)
	end
end
