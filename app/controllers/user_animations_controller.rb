# frozen_string_literal: true
class UserAnimationsController < ApplicationController

 def index
   @animations = UserAnimation.where(user_id: current_user.id)
 end

 def new
   @user_animations = UserAnimation.new
   @locations = ["Maharashtra", "Karnataka", "AP"]
   @anim_id = params[:id]
 end

 def create
    user_animation = current_user.user_animations.new(permit_params)
    user_animation.status = "Active"

    if user_animation.save
      redirect_to user_animations_path
    else
      render 'new'
    end

  end

  private

    def permit_params
      params["user_animation"].permit(:user_id, :start_date,:end_date,:location,:animation_data_id)
    end
 end
