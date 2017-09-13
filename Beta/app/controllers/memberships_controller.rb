class MembershipsController < ApplicationController

	before_action :set_project

	def new
		authorize @project
		
		@membership=@project.memberships.new
	end

	def create
		authorize @project

		@membership = @project.memberships.new(membership_params)
		@membership.project = @project

		if @membership.save
			redirect_to project_edit_leader_path(@project), notice: '新しいメンバーが招待されました。'
		else
			redirect_to @project, alert: 'メンバーの招待が失敗しました。'
	    end
    end

    def index
    	authorize @project

    	@users = @project.users.where.not("username is null")
		@invited = @project.users.where("username is null")
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
