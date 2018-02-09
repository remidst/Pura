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


end
