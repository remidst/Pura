class DocumentsController < ApplicationController
  def create
      @project = Project.find(params[:project_id])
      @document = @project.documents.create(document_params)
      redirect_to project_path(@project), notice: "The document has been uploaded."
  end

  def destroy
  end

  private
  def document_params
  	params.require(:document).permit(:attachment)
  end

end
