class ReportingMailer < ApplicationMailer


	def received_reporting(reporting)
		@reporting = reporting
		@contact = @reporting.contact
		@publisher = User.find(@reporting.publisher_id)
		@reporting_attachments = @reporting.reporting_attachments

		if @contact.care_manager_id.to_s == @publisher.id.to_s
			@receiver = User.find(@contact.care_manager_id)
		else
			@receiver = User.find(@contact.service_provider_id)
		end

		mail to: @receiver.email, subject: "#{@receiver.username}様、#{@publisher.username}様が新しい書類を共有致しました" unless @receiver.deleted_at.present?
	end



end
