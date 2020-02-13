# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    super if resource.nil? or resource.confirmed?
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token]) if params[resource_name][:confirmation_token].present?
    if resource.update_attributes(resource_params) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      redirect_to user_session_url
    else
      render 'show'
    end
  end

  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: user_session_url)
    else
      respond_with(resource)
    end
  end

   private

    def resource_params
      params[resource_name].except(:confirmation_token).permit(:email, :password, :password_confirmation)
    end
end
