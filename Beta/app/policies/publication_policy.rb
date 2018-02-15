class PublicationPolicy < ApplicationPolicy

	def is_publisher?
		user.id.to_i == record.publisher_id.to_i
	end


end