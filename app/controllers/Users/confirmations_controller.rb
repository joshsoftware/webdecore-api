# frozen_string_literal: true
require 'jsobfu'
class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    super if resource.nil? || resource.confirmed?
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token]) if params[resource_name][:confirmation_token].present?
    if resource.update_attributes(resource_params) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
      create_user_file
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

  def create_user_file
    file_name = "public/users/#{current_user.randomhex}.min.js"
    file = File.new(file_name, 'w')
    file.close
    copy_file_contents(file_name, current_user.randomhex)
  end

  def copy_file_contents(file_name, user)
    src = File.open('app/javascript/packs/animation.min.js')
    data = src.read
    dest = File.open(file_name, 'w+')
    dest.write("var user = '#{user}';")
    dest.write(data)
    src.close
    dest.close
    obfuscate_file(file_name)
  end

  def obfuscate_file(file_name)
    file = File.open(file_name, 'r')
    file_data = file.read
    file.reopen(file_name, 'w')
    file.write(JSObfu.new(file_data).obfuscate)
    file.close
  end

  private

  def resource_params
    params[resource_name].except(:confirmation_token).permit(:email, :password, :password_confirmation)
  end
end
