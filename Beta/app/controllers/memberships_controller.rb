class MembershipsController < ApplicationController

	before_action :set_project

	def new		
		@membership=@project.memberships.new
	end

	def create
		@membership = @project.memberships.new(membership_params)
		@membership.set_user_id!(current_user)

		if @membership.save
			redirect_to project_edit_leader_path(@membership.project), notice: '新しいメンバーが招待されました。'
		else
			redirect_to @project, warning: 'メンバーの招待が失敗しました。'
	    end
    end

    def index
		@invited = @project.users.where("username is null")
		@users = @project.users.where.not("username is null")
		
		ids_to_ignore = @invited.ids
		ids_to_ignore << current_user.id
		@tokens = @project.users.where.not(id: ids_to_ignore)
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
