# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include SetResources

  before_action :set_restaurants, only: %i[edit update]
  layout 'panel', only: %i[edit update]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/edit
  # def edit
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(_resource)
    new_user_registration_path
  end
end
