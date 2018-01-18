class ReportingsController < ApplicationController

  def new
    @contact = Contact.find(params[:contact_id])
  	@reporting = @contact.reportings.new
  	@reporting_attachment = @reporting.reporting_attachments.build
  end

  def create
    @contact = Contact.find(params[:contact_id])
  	@reporting = @contact.reportings.new(reporting_params)
    @reporting.set_publisher!(current_user)

  	respond_to do |format|
  		if @reporting.save
        if params[:reporting_attachments].present?
    			params[:reporting_attachments]['attachment'].each do |a|
    				@reporting_attachment = @reporting.reporting_attachments.create!(attachment: a)
    			end
        end

        #send email to recipient
        ReportingMailer.received_reporting(@reporting).deliver_later
        
  			format.html { redirect_to @contact, notice: 'レポート.請求書の共有が成功しました。' }
  		else
  			format.html { render action: 'new' }
  		end
  	end
  end

  def edit
    @contact = Contact.find(params[:contact_id])
    @reporting = Reporting.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:contact_id])
    @reporting = Reporting.find(params[:id])

    respond_to do |format|
      if @reporting.update(edit_params)
        format.html {redirect_to @contact, notice: 'エディットが成功しました。' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def delete
  end

  private

  def reporting_params
  	params.require(:reporting).permit(:title, :message, reporting_attachments_attributes: [:name, :id, :reporting_id, :attachment])
  end

  def edit_params
    params.require(:reporting).permit(:title, :message)
  end
end
