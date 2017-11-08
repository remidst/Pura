class DocumentsController < ApplicationController
  def create
      project = Project.find(params[:project_id])
      document = project.documents.create(document_params)

      project_users = project.users.where.not(id: current_user.id)

      project_users.each do |user|
        unless notification_document_exists?(current_user, project)
          notification = Notification.create(user: user, project: project, read: false)
          notification.new_document!
        end
      end

      redirect_to project_path(project), notice: "ファイルが案件のメンバーに共有されました。"
  end

  def edit
    authorize @document
  end

  def destroy
    document = Document.find(params[:id])
    project = Project.find(params[:project_id])
    authorize document

    document.destroy
    respond_to do |format|
      format.html { redirect_to project_path(project), notice: 'ファイルが削除されました。' }
      format.json { head :no_content }
    end
  end

  private

  def notification_document_exists?(user, project)
    user.notifications.where(read: false, project_id: project.id, content: "新しいファイルが共有されました。").present?
  end

  def document_params
  	params.require(:document).permit(:attachment, :type, :name, :user_ids => [])
  end

end
