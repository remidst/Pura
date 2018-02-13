class PublicationAttachmentsController < ApplicationController

  def destroy
    @publication = Publication.find(params[:publication_id])
    @publication_attachment = PublicationAttachment.find(params[:id])

    respond_to do |format|
      if @publication_attachment.destroy
        format.js 
      else
        format.html { redirect_to @publication.project, notice: "ファイルの削除が失敗しました。" }
      end
    end
  end

  def create
    @publication = Publication.find(params[:publication_id])
    @publication_attachment = @publication.publication_attachments.new(create_params)

    @publication_attachment.save!
  end

  private

  def create_params
    params.require(:publication_attachments).permit(:attachment)
  end


end
