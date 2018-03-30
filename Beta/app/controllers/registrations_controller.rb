	class RegistrationsController < Devise::RegistrationsController


	  #DELETE /resource
	  def destroy  
	    resource.soft_delete
	    resource.memberships.each do |membership|
	    	membership.delete
	    end
	    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)  
	    set_flash_message :notice, :destroyed if is_flashing_format?  
	    yield resource if block_given?  
	    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }  
	  end  


	  private

	  def sign_up_params
	    params.require(:user).permit(:username, :company, :email, :password, :password_confirmation)
	  end

	  def account_update_params
	    params.require(:user).permit(:username, :company, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar)
	  end

	  protected

	  def update_resource(resource, params)
	    resource.update_without_password(params)
	  end
	  
	end