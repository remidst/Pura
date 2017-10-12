class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :invite_members, :update_members, :edit_leader, :update, :update_leader, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @user=current_user
    @projects =@user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @documents=@project.documents.order('created_at DESC')

    @users=@project.users.where.not("username is null")
    @leader=@project.users.find(@project.leader_id)
    @invited=@project.users.where("username is null")

    @conversations = current_user.conversations.where(project_id: @project.id).order(:id)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    authorize @project
    @users = @project.users.where.not("username is null")
  end

  def invite_members
  	authorize @project
  	@invited = @project.users.where("username is null")
  	@users = @project.users.where.not("username is null")
		
	ids_to_ignore = @invited.ids
	ids_to_ignore << current_user.id
	@tokens = @project.users.where.not(id: ids_to_ignore)

	@membership=@project.memberships.build
  end

  def update_members
  	prjct = members_params

  	#make sure not to delete curent user (leader) from the project
    prjct[:user_tokens] << ",#{current_user.id}"

    #convert user tokens into an array
    array_user_tokens = prjct[:user_tokens].split(',')

    #update general conversation with all users
    conversation = @project.conversations.first
    conversation.update(user_ids: array_user_tokens)

    #get all combinations of 2 elements -i.e all the 1 to 1 conversations
    conversation_tokens = array_user_tokens.combination(2).to_a

    #iterate over conversation tokens to create each 1 to 1 conversation within the project
    conversation_tokens.each do |tokens|
        @project.conversations.create(user_ids: tokens)
    end


    respond_to do |format|
      if @project.update(prjct)

        format.html { redirect_to project_edit_leader_path(@project), notice: '案件にメンバーが招待されました。案件のオーナーを設定してください' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :invite_members }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit_leader
    authorize @project
    @users=@project.users.where.not("username is null")
    @leader = User.find(@project.leader_id)
  end

  def update_leader
    respond_to do |format|
      if @project.update(leader_params)
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
    @project =Project.new(project_params)
    @project.users << current_user
    @project.leader_id = current_user.id

    respond_to do |format|
      if @project.save(project_params)

        conversation = @project.conversations.create(user_ids: current_user.id)
        ProjectMailer.create_project(current_user, @project).deliver_now

        format.html { redirect_to project_invite_members_path(@project), notice: '案件名が登録されました。案件にメンバーを招待してください。' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
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
      prjct[:user_tokens] << ", #{current_user.id}"

      #unregistered invited users are not shown in user_tokens and should therefore be added
      @unregistered=@project.users.where("username is null")
      if @unregistered.present?
        unregistered_ids = @unregistered.ids
        unregistered_ids.map! {|x| x.to_i}
        array_user_tokens << unregistered_ids
        unregistered_ids_string = unregistered_ids.join(',')
        prjct[:user_tokens] << ", #{unregistered_ids_string}"
      else
      end

      #array operation to retrive only the id that will disapear
      array_delete_ids = (array_project_users - array_user_tokens)

      #if the array with ids to delete is not empty, transform it into array with user records
      array_delete_ids.map! { |id| User.find(id) }.join(',') if array_delete_ids.present?

      #create the conversations for the added users
      array_added_ids = (array_user_tokens - array_project_users)

      if array_added_ids.present?

        array_reconducted_ids = (array_user_tokens - array_added_ids)

        new_conversations_ids = array_added_ids.product(array_reconducted_ids)

        if new_conversations_ids.present?
          new_conversations_ids.each do |ids|
            @project.conversations.create(user_ids: ids)
          end
        end


        array_combination = array_added_ids.combination(2).to_a
        array_combination.compact!

        if array_combination.present?
          array_combination.each do |ids|
            @project.conversations.create(user_ids: ids)
          end
        end

      else
      end


      #update the group conversation
      main_conversation = @project.conversations.first
      main_conversation.update(user_ids: array_user_tokens)

      

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
            ProjectMailer.goodbye_registered_user(user, @project).deliver_now
          end

          #send email to leader to confirm deletion
          ProjectMailer.goodbye_registered_user_leader_notice(array_delete_ids, @project).deliver_now

          #delete all the conversations
          conversations = @project.conversations
          conversations.each do |conversation|
            conversation.destroy if (conversation.users & array_delete_ids).present?      
          end

        else
        end

        #send notification email if any change in project owner
        if prjct[:leader_id].present? && prjct[:leader_id].to_i != old_leader.id.to_i
          ProjectMailer.old_leader_email(old_leader, @project).deliver_now
          ProjectMailer.new_leader_email(old_leader, @project).deliver_now
        else
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
    def set_project
      @project = Project.find(params[:id])
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
