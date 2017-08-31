class DocumentPolicy < ApplicationPolicy
	attr_reader :user, :document

	def initialize(user, document)
		@user=user
		@document=document
	end

	def edit?
		user == document.user
	end

	def destroy?
		user == document.user
	end

end