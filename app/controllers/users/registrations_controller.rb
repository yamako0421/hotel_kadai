class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :full_name, :introduction])
  end

  # Override Devise method for updating resource without password
  def update_resource(resource, params)
    resource.update_with_password(params)
  end
end
