class MembershipsController < ApplicationController

	before_action :set_project, except: :update_members
	before_action :set_unread, except: :update_members

	def new		
		@membership=@project.memberships.new
	end

	def create

		authorize @project, :is_leader?

	    params = membership_params
	    user = User.find_by(email: params[:email])

	    if user.present? && user.deleted_at.present?
	    	flash[:alert] = "#{params[:email]}のアカウントは削除されてます。"
	    	redirect_to @project
	    else

	     	@membership = @project.memberships.new(membership_params)
	        @membership.set_user_id!(current_user)

			if @membership.save

				#email and notification to the new user
				added_user = User.find_by(email: params[:email])
				ProjectMailer.user_invited(added_user, @project).deliver_later

				redirect_to project_memberships_path(@membership.project), notice: '新しいメンバーが招待されました。'
			else
				redirect_to @project, warning: 'メンバーの招待が失敗しました。'
		    end
		end

    end

    def index
    	authorize @project, :is_leader?

		@unregistered = @project.users.where("username is null")
		@registered = @project.users.where.not("username is null")
		@leader = User.find(@project.leader_id)
		@members = @registered.where.not(id: @leader.id)
		@memberships_but_self = @project.memberships.where.not(user_id: @leader.id)
		
		ids_to_ignore = @project.users.ids
		@tokens = @project.users.where.not(id: ids_to_ignore)
    end

    def update_members
    	project = Project.find(params[:id])
    	authorize project, :is_leader?

    	membership = project.memberships.new(membership_params)
    	membership.set_user_id!(current_user)

    	params = membership_params

    	if membership.save

			#email and notification to the new user
			added_user = User.find_by(email: params[:email])
			ProjectMailer.user_invited(added_user, project).deliver_later

    		redirect_to project_edit_leader_path(membership.project), notice: '新しい責任者が招待されました'
    	else
    		redirect_to project, warning: '責任者の招待が失敗しました'
    	end
    end

    def destroy
    	authorize @project, :is_leader?
    	
    	@project = Project.find(params[:project_id])
    	@membership = Membership.find(params[:id])

    	respond_to do |format|
    	  if @membership.destroy
    	    format.js 
    	  else
    	    format.html { redirect_to @project, notice: "ユーザーの削除が失敗しました" }
    	  end
    	end
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
