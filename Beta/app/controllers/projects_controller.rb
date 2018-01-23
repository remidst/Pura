    class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]
  before_action :set_leader, only: [:show, :edit_leader]
  before_action :set_registered, only: [:show, :edit, :invite_members, :edit_leader, :update]
  before_action :set_unread

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  	#this section is to become obsolete
    @documents=current_user.documents.where(project_id: @project.id).order('created_at DESC')
    @members = @registered.where.not(id: @leader.id)
    @conversation = @project.conversations.first
    @messages = @conversation.messages.order('created_at ASC')
    @users_but_self = @project.users.where.not(id: current_user.id)
    #this section is to become obsolete

    #new project organization with publications
    @publications = Publication.where(project_id: @project.id)
    @publication = @project.publications.new
    @publication_attachment = @publication.publication_attachments.build
    @spec = @project.spec

    #to compare, id has to be an integer inside an array
    id = params[:v]
    notification_id = [id.to_i]

    #verify that the notification id is relevant, if so mark as read
    if verify_notification?(notification_id, @project, current_user)
      notification = Notification.find(id)
      notification.read!
    end

    #mark all messages as read
    read_all_messages!(current_user, @conversation)

    #mark all publications as read
    read_all_publications_and_comments!(current_user, @project)

  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    authorize @project
  end

  def invite_members
  	authorize @project

    @membership=@project.memberships.build

    #possible that all the below is useless
  	ids_to_ignore = @unregistered.ids
  	ids_to_ignore << current_user.id
  	@tokens = @project.users.where.not(id: ids_to_ignore)
    #possible that all the above is useless

  end

  def update_members
  	prjct = members_params

    new_user_tokens = prjct[:user_tokens].split(',')

    #add current user to the project user tokens
    prjct[:user_tokens] << ",#{current_user.id}"

    #convert the updated user tokens into an array
    array_user_tokens = prjct[:user_tokens].split(',')



    respond_to do |format|
      if @project.update(prjct)

        #update general conversation with all users
        general_conversation = @project.conversations.first
        general_conversation.update(user_ids: array_user_tokens)

        #send email to invited users and create notification
        users = new_user_tokens.map { |token| User.find(token) }
        users.each do |user|
          ProjectMailer.user_invited(user, @project).deliver_later
          notification = user.notifications.create(project_id: @project.id, read: false)
          notification.new_project!
        end


        format.html { redirect_to project_edit_leader_path(@project), notice: '案件にメンバーが招待されました。案件の担当ケアマネジャーを設定してください' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :invite_members }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit_leader
    authorize @project
  end

  def update_leader

    old_leader = User.find(@project.leader_id)

    respond_to do |format|
      if @project.update(leader_params)

        new_leader = User.find(@project.leader_id)

        if new_leader.id.to_i != old_leader.id.to_i
          #send email to new and old leader
          ProjectMailer.old_leader_email(old_leader, @project).deliver_later
          ProjectMailer.new_leader_email(old_leader, @project).deliver_later

          #send notification to new leader
          notification = new_leader.notifications.create(project_id: @project.id, read: false)
          notification.new_leader!
        end

        format.html { redirect_to @project, notice: '案件が登録されました。' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit_leader }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    project =Project.new(project_params)
    project.users << current_user
    project.leader_id = current_user.id

    respond_to do |format|
      if project.save(project_params)

        # create a general conversation with only the creator at this time
        conversation = project.conversations.create(user_ids: current_user.id)

        #send an email that confirms the creation of a project
        ProjectMailer.create_project(current_user, project).deliver_later

        format.html { redirect_to project_invite_members_path(project), notice: '案件名が登録されました。案件にメンバーを招待してください。' }
        format.json { render :show, status: :ok, location: project }
      else
        format.html { render :edit }
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    prjct = project_params 

    unless prjct[:user_tokens].nil?

      #create an array with the user ids that will disapear, and make sure to have only integers
      array_project_users=@project.user_ids
      array_user_tokens=prjct[:user_tokens].split(',')
      array_user_tokens.map! {|x| x.to_i }

      #make sure not to delete curent user (leader) from the project
      array_user_tokens << current_user.id.to_i
      prjct[:user_tokens] << ",#{current_user.id}"

      #add unregistered users to user tokens
      if @unregistered.present?
        unregistered_ids = @unregistered.ids
        array_user_tokens << unregistered_ids.join(',')
        array_user_tokens.map! {|x| x.to_i}
        unregistered_ids_string = unregistered_ids.join(',')
        prjct[:user_tokens] << ",#{unregistered_ids_string}"
      end

      #array operation to retrive only the ids that will disapear
      array_delete_ids = (array_project_users - array_user_tokens)

      #array operation to retrieve only the ids that were added
      array_added_ids = (array_user_tokens - array_project_users)

      #if the array with ids to delete is not empty, transform it into array with user records
      array_delete_ids.map! { |id| User.find(id) }.join(',') if array_delete_ids.present?

    else
    end

    #store old leader 
    old_leader = User.find(@project.leader_id)

    respond_to do |format|
      if @project.update(prjct)

        #send notification email to those who will be deleted from the project
        if prjct[:user_tokens].present? && array_delete_ids.present?

          #send emails to each deleted user
          array_delete_ids.each do |user|
            ProjectMailer.goodbye_registered_user(user, @project).deliver_later
          end

          #send email to leader to confirm deletion
          ProjectMailer.goodbye_registered_user_leader_notice(array_delete_ids, @project).deliver_later

          #delete all the conversations related to this user
          if @project.conversations.count > 1 
            @project.conversations.each do |conversation|
              unless conversation == @project.conversations.first
                conversation.destroy if (conversation.users & array_delete_ids).present?
              end
            end
          end
        end

        #send email and notification to those who were added (if any)
        if prjct[:user_tokens].present? && array_added_ids.present?
          added_users = array_added_ids.map {|user| User.find(user) }

          added_users.each do |user|
            ProjectMailer.user_invited(user, @project).deliver_later
            notification = user.notifications.create(project_id: @project.id, read: false)
            notification.new_project!
          end
        end

        #send notification email if any change in project owner
        if prjct[:leader_id].present? && prjct[:leader_id].to_i != old_leader.id.to_i
          ProjectMailer.old_leader_email(old_leader, @project).deliver_later
          ProjectMailer.new_leader_email(old_leader, @project).deliver_later

          new_leader = User.find(@project.leader_id)
          notification = new_leader.notifications.create(project_id: @project.id, read: false)
          notification.new_leader!
        end

        #update the general conversation
        unless prjct[:user_tokens].nil? 
          #update the group conversation
          general_conversation = @project.conversations.first
          general_conversation.update(user_ids: array_user_tokens)
        end


        format.html { redirect_to @project, notice: '案件情報のアップデートが成功しました。' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    authorize @project
    
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: '案件が削除されました。' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.

    def verify_notification?(id, project, user)
      (project.notification_ids & id).present? && (user.notification_ids & id).present?
    end

    def set_unread
      @unread = current_user.notifications.where(read: false)
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def set_leader
      @leader = @project.users.find(@project.leader_id)
    end

    def set_registered
      @registered=@project.users.where.not("username is null")
      @unregistered=@project.users.where("username is null")
    end

    def read_all_messages!(user, conversation)
      messages = conversation.messages.last(10)
      messages.each do |msg|
        readmark = Readmark.where(user_id: user.id, read: false, message_id: msg.id)
        readmark.message_read! if readmark.present?
      end
    end

    def read_all_publications_and_comments!(user, project)
    	project.publications.each do |publication|
    		publication_readmark = PublicationReadmark.where(user_id: user.id, read: false, publication_id: publication.id)
    		publication_readmark.publication_read! if publication_readmark.present?

        publication.publication_comments.each do |publication_comment|
          publication_comment_readmark = PublicationCommentReadmark.where(publication_comment_id: publication_comment.id, read: false, user_id: user.id)
          publication_comment_readmark.publication_comment_read! if publication_comment_readmark.present?
        end
    	end
    end

    def members_params
    	params.require(:project).permit(:user_tokens)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:project_name, :leader_id, :user_tokens)
    end

    def leader_params
      params.require(:project).permit(:leader_id)
    end
end
