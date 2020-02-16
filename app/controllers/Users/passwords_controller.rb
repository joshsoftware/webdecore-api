# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/password
  def create
    user_params = params[:user]
    user = resource_class.find_by_email(user_params[:email])
    if user
      if user.confirmed_at?
        super
      else
        flash[:alert] = t('unconfirmed_email_forgot_password')
        respond_with({}, location: user_session_url)
      end
    else
      flash[:alert] = t('email_does_not_exists')
      respond_with({}, location: user_session_url)
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #  super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
