class MembershipsController < ApplicationController


	def create
		@project = Project.find(params[:project_id])
		@membership = @project.memberships.create(membership_params)
		@membership.set_project!(@project)

		redirect_to project_path(@project), notice: "The user has been invited."
	end

	def edit
	end

	def destroy
	end

	private
	def membership_params
		params.require(:membership).permit(:user_id)
	end
end
