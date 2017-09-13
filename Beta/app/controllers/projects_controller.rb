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

        format.html { redirect_to new_project_membership_path(@project), notice: '案件名が登録されました。案件にメンバーを招待してください。' }
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
    respond_to do |format|
      if @project.update(project_params)
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
      params.require(:project).permit(:project_name)
    end

    def leader_params
      params.require(:project).permit(:leader_id)
    end
end
