class DocumentsController < ApplicationController
  def create
      project = Project.find(params[:project_id])
      document = project.documents.create(document_params)
      document.set_user!(current_user)

      project_users = project.users.where.not(id: current_user.id)

      project_users.each do |user|
        notification = Notification.create(user: user, project: project, read: false)
        notification.new_document!
      end

      redirect_to project_path(project), notice: "ファイルが案件のメンバーに共有されました。"
  end

  def edit
    authorize @document
  end

  def destroy
    authorize @document
  end

  private
  def document_params
  	params.require(:document).permit(:attachment, :user)
  end

end
