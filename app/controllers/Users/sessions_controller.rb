# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
before_action :configure_sign_in_params, only: [:create]
	def create
	end
	def new
		super
		obj = JsMinfier.new('custom.js')
		obj.compress
	end
  # protected
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
