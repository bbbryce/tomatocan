class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  def update 
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.permalink)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to user_profile_path(current_user.permalink)
    else
      render user_profileinfo_path(current_user.permalink)
    end
  end

    def profileinfo #I'm pretty sure I dont this
      @user = User.find(current_user.permalink)
      build_resource(@user)
      respond_with self.resource
    end
  
end