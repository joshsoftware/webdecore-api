# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  after_action :create_user_file, only: [:create, :delete]

  # # GET /resource/sign_up
  #  def new
  #    super
  #  end

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

  private

    def create_user_file
      user_id = current_user.id
      file_name = "public/animations/#{user_id}.min.js"
      fileobject = File.new(file_name, "w+")
      fileobject.close()
      copy_file_contents(file_name)
    end

    def copy_file_contents(file_name)
      src = File.open("app/javascript/packs/global_animation_data.min.js")
      data = src.read()
      dest = File.open(file_name, "w+")
      dest.write("var user= #{current_user.id};")
      dest.write(data)
      src.close()
      dest.close()
    end

end
