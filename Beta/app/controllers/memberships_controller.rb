class MembershipsController < ApplicationController

	before_action :set_project, only: [:new, :create, :index]

	def new		
		@membership=@project.memberships.new
	end

	def create
		@membership = @project.memberships.new(membership_params)
	    @membership.set_user_id!(current_user)

	    params=membership_params

		if @membership.save

			@new_user = User.find_by_email(params[:email])

			array_ids=@project.user_ids
			puts "array_ids"
			puts array_ids

			main_conversation=@project.conversations.first
			main_conversation.update(user_ids: array_ids)

			ids = @project.user_ids
			new_user_id = [@new_user.id.to_i]

			old_ids=ids - new_user_id
			puts "old_ids"
			puts old_ids

			new_conversations = old_ids.product(new_user_id)
			puts "new_conversations"
			puts new_conversations

			if new_conversations.present?
		        new_conversations.each do |ids|
		           @project.conversations.create(user_ids: ids)
		        end
		    end



			redirect_to project_path(@membership.project), notice: '新しいメンバーが招待されました。'
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

    def update_members
    	@project = current_user.projects.find(params[:id])
    	@membership = @project.memberships.new(membership_params)
    	@membership.set_user_id!(current_user)

    	if @membership.save
    		redirect_to project_edit_leader_path(@membership.project), notice: '新しいメンバーが招待されました。'
    	else
    		redirect_to @project, warning: 'メンバーの招待が失敗しました。'
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
