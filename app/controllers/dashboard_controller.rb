class DashboardController < ApplicationController
  def index
     @id = current_user.id
     @user = User.find_by_id(@id)
  end
end
