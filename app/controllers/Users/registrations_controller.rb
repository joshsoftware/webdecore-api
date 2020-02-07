# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  after_action :create_user_file, only: [:create]
  before_action :delete_user_file, only: [:destroy]
  # before_action :configure_account_update_params, only: [:update]

  # # GET /resource/sign_up
    # def new
    #   super
    # end

  # POST /resource
   # def create
   #   super
   # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

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
  def create_user_file
    @user = current_user.id
    @file_name = "public/users/#{@user}.js"
    @file = File.new(@file_name,"w")
    @file.close()
    copy_file_contents(@file_name,@user)
  end

  def copy_file_contents(file_name,user)
      src = File.open("app/javascript/packs/start.js")
      data = src.read()
      dest = File.open(file_name,"w+")
      dest.write("var user = '#{user}';")
      dest.write(data)
      src.close()
      dest.close()
    end

  def delete_user_file
    File.delete("public/users/#{current_user.id}.js")
  end
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name,:contact_number])
  end
end
