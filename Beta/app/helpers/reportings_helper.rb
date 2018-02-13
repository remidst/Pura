module ReportingsHelper

	def reporting_header(reporting)
		contact = reporting.contact
		publisher = reporting.publisher
		publisher == contact.care_manager ? receiver = contact.service_provider : receiver = contact.care_manager

		if publisher == current_user
			"#{receiver.username}様への書類：#{reporting.title}"
		else
			"#{publisher.username}様からの書類：#{reporting.title}"
		end
	end

	def receiver(reporting)
		if reporting.publisher == reporting.contact.care_manager
			reporting.contact.service_provider
		else
			reporting.contact.care_manager
		end
	end

end
