# frozen_string_literal: true
class UserAnimationsController < ApplicationController
  @@anim_id = ""

  def index
    @animations = UserAnimation.where(user_id: current_user.id)
  end

  def new
    @locations = ["Maharashtra", "Delhi", "Hydrabad"]
    @@anim_id = params[:id]
  end

  def create
    status = "active"
    params = permit_params
    UserAnimation.create(start_date: params[:start_date], end_date: params[:end_date], user_id: current_user.id,
      animation_data_id: @@anim_id, status: status,location: params[:location])
    redirect_to user_animations_path
  end

  private

  def permit_params
    params["user_animation"].permit(:start_date,:end_date,:location)
  end
end
