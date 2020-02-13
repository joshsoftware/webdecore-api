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
      if user_animation.save
        redirect_to user_animations_path
      else
        redirect_to_new
      end
    else
      redirect_to_new
    end
  end

  def destroy
    delete_order = UserAnimation.where(id: params[:id])[0]
    if delete_order.destroy
      flash[:alert] = "Order Deleted Successfully"
      redirect_to user_animations_path
    else
      flash[:alert] = "Couldn't delete"
      redirect_to user_animations_path
    end
  end

  def edit
    @edit_order = UserAnimation.where(id: params[:id])[0]
  end

  def update
    update_user = UserAnimation.where(id: params[:id])[0]
    if edit_validate_date
      if update_user.update(permit_params)
        flash[:notice] = "Order Updated Successfully"
        redirect_to user_animations_path
      else
        redirect_to user_animation_path
      end
    else
      flash[:alert] = "Couldn't Update Order !!!"
      redirect_to edit_user_animation_path
    end
  end

  def inactive
    inactive_order = UserAnimation.where(id: params[:id])[0]
    inactive_order.update(status: "Inactive")
    flash[:notice] = "Deactivated Successfully"
    redirect_to user_animations_path
  end
  private

    def permit_params
      params.require(:user_animation).permit(:start_date, :end_date, :location, :animation_data_id, :amount)
    end

    def validate_date
      new_start = params[:user_animation][:start_date]
      new_end = params[:user_animation][:end_date]
      location = params[:user_animation][:location]
      @users = UserAnimation.where(user_id: current_user.id, location: location, status: "Active")
      @users.none? do |user|
        (new_start.to_date >= user.start_date && new_start.to_date <= user.end_date) ||
        (new_start.to_date <= user.start_date && new_end.to_date >= user.start_date)
      end
    end

    def edit_validate_date
      new_start = params[:user_animation][:start_date]
      new_end = params[:user_animation][:end_date]
      location = params[:user_animation][:location]
      @orders = UserAnimation.where(user_id: current_user.id, location: location, status: "Active")
                .where.not(id: params[:id])
      @orders.none? do |order|
        (new_start.to_date >= order.start_date && new_start.to_date <= order.end_date) ||
        (new_start.to_date <= order.start_date && new_end.to_date >= order.start_date)
      end
    end

    def redirect_to_new
      flash[:alert] = "Animation already added for #{params[:user_animation][:location]}"
      redirect_to purchase_path(params[:user_animation][:category_id],
        params[:user_animation][:sub_category_id], params[:user_animation][:animation_data_id])
    end

end
