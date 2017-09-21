class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :edit_leader, :update, :update_leader, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @user=current_user
    @projects =@user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @messages=@project.messages.order('created_at DESC')
    @documents=@project.documents.order('created_at DESC')

    @users=@project.users.where.not("username is null")
    @leader=@project.users.find(@project.leader_id)
    @invited=@project.users.where("username is null")
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
    @leader = User.find(@project.leader_id)


    respond_to do |format|
      if @project.save(project_params)

        ProjectMailer.create_project(current_user, @project).deliver_now

        format.html { redirect_to project_memberships_path(@project), notice: '案件名が登録されました。案件にメンバーを招待してください。' }
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

    if prjct[:user_tokens].present?

      #create an array with the user ids that will disapear prepare the matrix, and make sure to have only integers
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


    else
    end

    #store old leader 
    old_leader = User.find(@project.leader_id)

    respond_to do |format|
      if @project.update(prjct)

        #send notification email to those who will be deleted from the project
        if prjct[:user_tokens].present? && array_delete_ids.present?
          array_delete_ids.each do |user|
            ProjectMailer.goodbye_registered_user(user, @project).deliver_now
          end
          ProjectMailer.goodbye_registered_user_leader_notice(array_delete_ids, @project).deliver_now
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:project_name, :leader_id, :user_tokens)
    end

    def leader_params
      params.require(:project).permit(:leader_id)
    end
end
