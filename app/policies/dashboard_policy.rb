class DashboardPolicy < Struct.new(:user, :dashboard)
  attr_reader :user

  def initialize(user, dashboard)
    @user = user
    @dashboard = dashboard
  end

  def users_details?
    @user.role == "admin"
  end

  def order_details?
    @user.role == "admin"
  end
end
