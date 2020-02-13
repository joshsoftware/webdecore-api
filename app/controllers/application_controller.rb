# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource_or_scope)
    dashboard_index_url
  end

  def after_sign_out_path_for(_resource_or_scope)
    user_session_url
  end

  def after_sign_up_path_for(_resource_or_scope)
    dashboard_index_url
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :contact_number])
    end
  
    def password_required?
      return false if skip_password_validation
      super
    end

  private

  def user_not_authorized
    flash[:alert] = t('user_not_authorized')
    redirect_to(request.referrer || dashboard_index_url)
  end

end
