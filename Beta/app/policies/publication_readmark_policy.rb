class PublicationReadmarkPolicy < ApplicationPolicy

	def is_reader?
		user == record.user
	end


end