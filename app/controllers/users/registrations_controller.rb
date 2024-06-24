class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  protected

  # ユーザー登録時、下記も同時に登録.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :full_name, :introduction])
  end

  # パスワードなしで登録可能
  def update_resource(resource, params)
    resource.update_with_password(params)
  end
end
