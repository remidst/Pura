class ReportingsController < ApplicationController

  def new
    @contact = Contact.find(params[:contact_id])
  	@reporting = @contact.reportings.new
  	@reporting_attachment = @reporting.reporting_attachments.build
  end

  def create
    @contact = Contact.find(params[:contact_id])
  	@reporting = @contact.reportings.new(reporting_params)

  	respond_to do |format|
  		if @reporting.save
  			params[:reporting_attachments]['attachment'].each do |a|
  				@reporting_attachment = @reporting.reporting_attachments.create!(attachment: a)
  			end
  			format.html { redirect_to @contact, notice: 'レポート.請求書の共有が成功しました。' }
  		else
  			format.html { render action: 'new' }
  		end
  	end
  end

  def update
  end

  def delete
  end

  private

  def reporting_params
  	params.require(:reporting).permit(:title, :message, reporting_attachments_attributes: [:name, :id, :reporting_id, :attachment])
  end
end
