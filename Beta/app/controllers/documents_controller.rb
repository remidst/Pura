class DocumentsController < ApplicationController
  def create
      @project = Project.find(params[:project_id])
      @document = @project.documents.create(document_params)
      @document.set_user!(current_user)
      redirect_to project_path(@project), notice: "ファイルが案件のメンバーに共有されました。"
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
