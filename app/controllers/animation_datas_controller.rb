# frozen_string_literal: true
class AnimationDatasController < ApplicationController
  def show
    @animations = AnimationData.where(category_id: params[:sub_category_id])
    @primary_category_id = params[:id]
    @secondary_category_id = params[:sub_category_id]
  end

  def demo
    @animation_json = AnimationData.find_by(id: params[:animation_data_id]).animation_json.to_json
  end

  def new
    @new_animation = AnimationData.new
    authorize @new_animation
  end

  def create
    file_data = params[:animation_datas][:animation_json].read
    params[:animation_datas][:animation_json] = file_data.as_json
    params[:animation_datas][:category_id] = params[:sub_category_id]
    if AnimationData.create(permit_params)
      redirect_to animations_path
    else
      redirect_to new_animation_path
    end
  end

  private
    def permit_params
      params.require(:animation_datas).permit(:animation_name, :animation_price,:category_id,
                     :picture, :animation_json)
    end
end