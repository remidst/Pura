class CorporationPolicy < ApplicationPolicy

	def is_subscribed?
		record.id != 1
	end


end