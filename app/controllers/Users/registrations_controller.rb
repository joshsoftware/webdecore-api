# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :account_update_params, only: [:update]
  before_action :delete_user_file, only: [:destroy]
  before_action :generate_uuid, only: [:new, :create]

  # GET /resource/sign_up
  # def new
  #  super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    render 'edit'
  end

  # PUT /resource
  def update
    resource_updated = update_resource(resource, account_update_params)
    if resource_updated
      flash[:notice] = I18n.t('user.profile_update')
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :contact_number, :uuid])
  end

  def delete_user_file
    File.delete("public/users/#{current_user.uuid}.min.js")
  end

  def account_update_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation, :contact_number)
  end

  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  def generate_uuid
    @uuid = SecureRandom.uuid
  end

end
