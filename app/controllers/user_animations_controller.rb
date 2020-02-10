# frozen_string_literal: true

class UserAnimationsController < ApplicationController

  def index
    @animations = UserAnimation.where(user_id: current_user.id)
  end

  def new
    @animation_id = params[:animation_data_id]
    @price = AnimationData.find(@animation_id).animation_price
    @category_id = params[:id]
    @sub_category_id = params[:sub_category_id]
  end

  def create
    if validate_date
      user_animation = current_user.user_animations.new(permit_params)
      user_animation.status = "Active"
      if user_animation.save!
        redirect_to user_animations_path
      else
        redirect_to_new
      end
    else
      redirect_to_new
    end
  end

  def destroy
    delete_order = UserAnimation.find(params[:id]).destroy
    redirect_to user_animations_path
  end

  def edit
    @edit_order = UserAnimation.find(params[:id])
    @price = @edit_order.animation_data.animation_price
  end

  def update
    update_user = UserAnimation.find(params[:id])
    update_user.update(permit_params)
    redirect_to user_animations_path
  end
  private

    def permit_params
      params.require(:user_animation).permit(:start_date, :end_date, :location, :animation_data_id, :amount)
    end

    def validate_date
      new_start = params[:user_animation][:start_date]
      new_end = params[:user_animation][:end_date]
      @users = UserAnimation.where(user_id: current_user.id, location: params[:user_animation][:location])
      (@users).none? { |user| (new_start.to_date >= user.start_date && new_start.to_date <= user.end_date) ||
      (new_start.to_date <= user.start_date && new_end.to_date >= user.start_date) } ? true : false
    end

    def redirect_to_new
      flash[:alert] = "Animation already added for #{params[:user_animation][:location]}"
      redirect_to purchase_path(params[:user_animation][:category_id],
                                params[:user_animation][:sub_category_id],
                                params[:user_animation][:animation_data_id])
    end
end
