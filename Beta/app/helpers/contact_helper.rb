module ContactHelper
	def contact_name(contact)
		if contact.care_manager_id.to_s == current_user.id.to_s
			contact.service_provider.username.present? ? contact.service_provider.username : contact.service_provider.email
		elsif contact.service_provider_id.to_s == current_user.id.to_s
			contact.care_manager.username
		end
	end

	def contact_company(contact)
		if contact.care_manager_id.to_s == current_user.id.to_s
			contact.service_provider.company.present? ? contact.service_provider.company : contact.service_provider.company
		elsif contact.service_provider_id.to_s == current_user.id.to_s
			contact.care_manager.company
		end
	end

	def contact_role(contact)
		if contact.care_manager_id.to_s == current_user.id.to_s
			"責任者："
		elsif contact.service_provider_id.to_s == current_user.id.to_s
			"ケアマネージャー"
		end
	end

	def publisher_name(reporting)
		User.find(reporting.publisher_id).username
	end
end
