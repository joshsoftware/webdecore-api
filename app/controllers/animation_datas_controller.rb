# frozen_string_literal: true
class AnimationDatasController < ApplicationController
  def show
    @animations = AnimationData.where(category_id: params[:sub_category_id])
    @primary_category_id = params[:id]
    @secondary_category_id = params[:sub_category_id]
  end

  def demo
    @animation_json = AnimationData.find_by(animation_name: params[:animation_name]).animation_json.to_json
  end
end
