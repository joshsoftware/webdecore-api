# frozen_string_literal: true
class AnimationDatasController < ApplicationController
  def show
    @animations = AnimationData.where(category_id: params[:sub_category_id]).order(id: :ASC)
    if @animations.empty?
      redirect_to sub_categories_path
    end
    @primary_category_id = params[:id]
    @secondary_category_id = params[:sub_category_id]
  end

  def demo
    @animation_json = AnimationData.find_by(id: params[:animation_data_id])
    if (@animation_json.nil?)
      redirect_to animations_path
    end
    @animation_json = @animation_json.animation_json.to_json
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
      redirect_to animations_path
    else
      redirect_to new_animation_path
    end
  end

  def edit
    @animation = AnimationData.find_by(id: params[:animation_data_id])
    if @animation.nil?
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
    redirect_to animations_path
  end

  def destroy
     AnimationData.find_by(id: params[:animation_data_id]).destroy
     redirect_to animations_path
  end

  private
    def permit_params
      params.require(:animation_datas).permit(:animation_name, :animation_price,:category_id,:picture, :animation_json)
    end
end
