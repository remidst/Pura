class ReportingAttachmentsController < ApplicationController

  def destroy
    @reporting = Reporting.find(params[:reporting_id])
    @reporting_attachment = ReportingAttachment.find(params[:id])

    respond_to do |format|
      if @reporting_attachment.destroy
        format.js 
      else
        format.html { redirect_to @reporting.contact, notice: "ファイルの削除が失敗しました。" }
      end
    end
  end

  def create
    @reporting = Reporting.find(params[:reporting_id])
    @reporting_attachment = @reporting.reporting_attachments.new(create_params)

    @reporting_attachment.save!
  end

  private

  def create_params
    params.require(:reporting_attachments).permit(:attachment)
  end


end
