# frozen_string_literal: true
class AnimationDatasController < ApplicationController

  def show
    @animations = AnimationData.where(category_id: params[:sub_category_id]).order(id: :ASC)

    if @animations.empty?
      flash[:alert] = t('animation_not_found')
      redirect_to sub_categories_path
    else
      sub_category = Category.find(params[:sub_category_id])
      add_breadcrumb "Category", categories_path
      add_breadcrumb sub_category.primarycategory.category_name, sub_categories_path
      add_breadcrumb sub_category.category_name
    end
    @primary_category_id = params[:id]
    @secondary_category_id = params[:sub_category_id]
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
    authorize @new_animation
  end

  def create
    file_data = params[:animation_datas][:animation_json].read
    params[:animation_datas][:animation_json] = file_data.as_json
    params[:animation_datas][:category_id] = params[:sub_category_id]
    params[:animation_datas][:animation_json].force_encoding("UTF-8")
    if AnimationData.create(permit_params)
      flash[:notice] = t('create_success')
      redirect_to animations_path
    else
      flash[:alert] = t('create_error')
      redirect_to new_animation_path
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
      params.require(:animation_datas).permit(:animation_name, :animation_price,:category_id,:picture, :animation_json)
    end
end
