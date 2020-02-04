# frozen_string_literal: true

class AnimationDatasController < ApplicationController

  
  def show
    pp params
    @animations = AnimationData.where(category_id: params[:sub_category_id])
  end
  
end
