class MembershipsController < ApplicationController

	before_action :set_project, except: :update_members
	before_action :set_unread, except: :update_members

	def new		
		@membership=@project.memberships.new
	end

	def create


	    params=membership_params
	    user = User.find_by(email: params[:email])

	    unless user.deleted_at.present?
	     	@membership = @project.memberships.new(membership_params)
	        @membership.set_user_id!(current_user)

			if @membership.save

				#update the general conversation
				general_conversation=@project.conversations.first
				general_conversation.update(user_ids: @project.user_ids)

				#email and notification to the new user
				added_user = User.find_by(email: params[:email])
				ProjectMailer.user_invited(added_user, @project).deliver_later
				notification = added_user.notifications.create(project_id: @project.id, read: false)
				notification.new_project!

				redirect_to project_path(@membership.project), notice: '新しいメンバーが招待されました。'
			else
				redirect_to @project, warning: 'メンバーの招待が失敗しました。'
		    end
		else
			flash[:alert] = "#{params[:email]}のアカウントは削除されております。"
			redirect_to @project
		end
    end

    def index
		@unregistered = @project.users.where("username is null")
		@registered = @project.users.where.not("username is null")
		@leader = User.find(@project.leader_id)
		@members = @registered.where.not(id: @leader.id)
		
		ids_to_ignore = @unregistered.ids
		ids_to_ignore << current_user.id
		@tokens = @project.users.where.not(id: ids_to_ignore)
    end

    def update_members
    	project = current_user.projects.find(params[:id])
    	membership = project.memberships.new(membership_params)
    	membership.set_user_id!(current_user)

    	params = membership_params

    	if membership.save

			# update general conversation
			general_conversation=project.conversations.first
			general_conversation.update(user_ids: project.user_ids)

			#email and notification to the new user
			added_user = User.find_by(email: params[:email])
			ProjectMailer.user_invited(added_user, project).deliver_later
			notification = added_user.notifications.create(project_id: project.id, read: false)
			notification.new_project!

    		redirect_to project_edit_leader_path(membership.project), notice: '新しい責任者が招待されました。'
    	else
    		redirect_to project, warning: '責任者の招待が失敗しました。'
    	end
    end

    def destroy
    end
	

	private

	def set_project
		@project = current_user.projects.find(params[:project_id])
	end

	def set_unread
		@unread = @project.notifications.where(user: current_user, read: false)
	end
		
	def membership_params
		params.require(:membership).permit(:email)
	end
end
