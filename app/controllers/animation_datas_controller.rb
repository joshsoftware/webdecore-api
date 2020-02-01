# frozen_string_literal: true

class AnimationDatasController < ApplicationController
  def index
    @animations = AnimationData.all
    puts @animations
  end

  def show
    @categories = AnimationData.where(categories_id: params[:id])

    if @categories
      @count = AnimationData.where(categories_id: params[:id]).count
      @outer = (@count - 1) / 4 + 1
    end
  end
end
