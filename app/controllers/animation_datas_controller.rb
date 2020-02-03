# frozen_string_literal: true

class AnimationDatasController < ApplicationController

  def show
    @animations = AnimationData.where(category_id: params[:category_id])
  end
  
end
