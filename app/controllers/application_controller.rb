class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  def after_sign_in_path_for(resource_or_scope)
    dashboard_index_url
  end

  def after_sign_up_path_for(resource_or_scope)
    dashboard_index_url
  end
end
