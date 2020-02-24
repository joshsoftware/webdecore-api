# frozen_string_literal: true

class UserAnimationsController < ApplicationController

  def index
    @animations = UserAnimation.where(user_id: current_user.id)
  end

  def new
    @animation_id = params[:animation_data_id]
    @price = AnimationData.find_by(id: @animation_id).animation_price
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
    order = UserAnimation.where(id: params[:id]).first
    if order.present?
      if order.destroy
        flash[:alert] = t('delete_success')
      else
        flash[:alert] = t('delete_error')
      end
    else
      flash[:alert] = t('order_not_found')
    end
    redirect_to user_animations_path
  end

  def edit
    @order = UserAnimation.where(id: params[:id]).first
    @animation_id = @order.animation_data_id
    @price = AnimationData.find_by(id: @animation_id).animation_price
  end

  def update
    user = UserAnimation.where(id: params[:id]).first
    if edit_validate_date
      if user.update(permit_params)
        flash[:notice] = t('update_success')
        redirect_to user_animations_path
      else
        flash[:alert] = t('update_error')
        redirect_to user_animation_path
      end
    else
      flash[:alert] = t('update_error')
      redirect_to edit_user_animation_path
    end
  end

  def inactive
    order = UserAnimation.where(id: params[:id]).first
    if order.present?
      if order.update!(status: "Inactive")
        flash[:notice] = t('deactivate_success')
        redirect_to user_animations_path
      else
        flash[:notice] = t('deactivate_error')
        redirect_to user_animations_path
      end
    else
      flash[:alert] = t('order_not_found')
      redirect_to user_animations_path
    end
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
      @orders = UserAnimation.where(user_id: current_user.id, location: location, status: "Active").
        where.not(id: params[:id])
      @orders.none? do |order|
        (new_start.to_date >= order.start_date && new_start.to_date <= order.end_date) ||
        (new_start.to_date <= order.start_date && new_end.to_date >= order.start_date)
      end
    end

    def redirect_to_new
      flash[:alert] = t('animation_conflict_for_same_date_location')
      redirect_to purchase_path(params[:user_animation][:category_id],
        params[:user_animation][:sub_category_id], params[:user_animation][:animation_data_id])
    end

end
