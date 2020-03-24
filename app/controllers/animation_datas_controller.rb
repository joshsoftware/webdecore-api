# frozen_string_literal: true
class AnimationDatasController < ApplicationController

  def show
    @animations = AnimationData.where(category_id: params[:sub_category_id]).order(id: :ASC)

    if @animations.empty?
      flash[:alert] = t('animation_not_found')
    else
      sub_category = Category.find(params[:sub_category_id])
      add_breadcrumb "Category", categories_path
      add_breadcrumb sub_category.primarycategory.category_name, sub_categories_path
      add_breadcrumb sub_category.category_name
    end
    @primary_category_id = params[:id]
    @secondary_category_id = params[:sub_category_id]
  end

  def my_animations
    @animations = AnimationData.where(user_id: current_user)
    if @animations.empty?
      flash[:alert] = t('animation_not_found')
      redirect_to dashboard_index_path
    end
  end

  def demo
    @animation = AnimationData.find_by(id: params[:animation_data_id])
    if (@animation.nil?)
      flash[:alert] = t('animation_not_found')
      redirect_to animations_path
    else
      @animation_json = @animation.animation_json.to_json
    end
  end

  def new
    @new_animation = AnimationData.new
  end

  def create
    file_data = params[:animation_datas][:animation_json].read
    params[:animation_datas][:animation_json] = file_data.as_json
    params[:animation_datas][:animation_json].force_encoding("UTF-8")
    params[:animation_datas][:category_id] = params[:sub_category_id]
    animation = current_user.animation_datas.new(permit_params)

    if animation.save!
      flash[:notice] = t('create_success')
      if current_user.role == 'user'
        redirect_to my_animations_path
      else
        redirect_to animations_path
      end
    else
      flash[:alert] = t('create_error')
      if current_user.role == 'user'
        redirect_to new_animation_data_path
      else
        redirect_to new_animation_path
      end
    end
  end

  def edit
    @animation = AnimationData.find_by(id: params[:animation_data_id])
    if @animation.nil?
      flash[:alert] = t('animation_not_found')
      redirect_to animations_path
    end
  end

  def update
    unless params[:animation_datas][:animation_json].nil?
      file_data = params[:animation_datas][:animation_json].read
      params[:animation_datas][:animation_json] = file_data.as_json
      params[:animation_datas][:animation_json].force_encoding("UTF-8")
    end
    AnimationData.find_by(id: params[:animation_data_id]).update(permit_params)
    flash[:notice] = t('update_success')
    redirect_to animations_path
  end

  def destroy
     AnimationData.find_by(id: params[:animation_data_id]).destroy
     flash[:alert] = "Animation deleted"
     redirect_to animations_path
  end

  private
    def permit_params
      params.require(:animation_datas).permit(:animation_name, :animation_price, :category_id, :picture, :animation_json)
    end
end
