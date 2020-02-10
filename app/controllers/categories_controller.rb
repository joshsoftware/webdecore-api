# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = Category.primary
  end

  def new
    @primary_category = Category.new
    authorize @primary_category
  end

  def create
    @primary_categories = Category.create(permit_params)
    redirect_to categories_path
  end

  def show
    @primary_category = Category.find_by(id: params[:id])
    @categories = @primary_category.secondary_categories
  end

  private

  def permit_params
    params.require(:category).permit(:category_name, :category_description, :picture)
  end
end
