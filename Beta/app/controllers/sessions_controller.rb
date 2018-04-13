class SessionsController < Devise::SessionsController

	def new
		@login_signup = true
		super
	end

end