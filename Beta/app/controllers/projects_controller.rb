class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @user=current_user
    @projects =@user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project=Project.find(params[:id])
    @messages=@project.messages.order('created_at DESC')
    @documents=@project.documents.order('created_at DESC')
    @users=@project.users
    @leader=@users.find(@project.leader_id )


  end

  # GET /projects/new
  def new
    @project = Project.new
    @list = Project.new
    @list.users << User.find([current_user.id, @project.leader_id, @project.user_tokens])
  end

  # GET /projects/1/edit
  def edit
    authorize @project
  end

  # POST /projects
  # POST /projects.json
  def create
    @project =Project.new(project_params)
    @project.users << User.find([current_user.id, @project.leader_id, @project.user_tokens])
    @users = @project.users


    respond_to do |format|
      if @project.save(project_params)

        #send a notification email to each user
        @users.each do |user|
          ProjectMailer.new_project_users(user, @project).deliver_later
        end

        format.html { redirect_to @project, notice: '新しい案件が登録されました。' }
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
      params.require(:project).permit(:project_name, :leader_id, :user_id, :user_tokens)
    end
end
