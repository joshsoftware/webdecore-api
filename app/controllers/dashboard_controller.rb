# frozen_string_literal: true
class DashboardController < ApplicationController

  def users_details
    authorize :dashboard, :users_details?
    @users = User.all
  end
  def order_details
    authorize :dashboard, :order_details?
    @orders = UserAnimation.all
  end
end
