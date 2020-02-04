# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = Category.primary
  end

  def new
    @primary_category = Category.new
  end

  def create
    @primary_categories = Category.create(permit_params)
    redirect_to categories_path
  end

  def sub_categories
    #@secondary_categories = Category.create(permit_params)
    @categories = Category.find_by(id: params[:id]).secondary_categories
    @cat = Category.find_by(id: params[:id])
    # @categories = Category.find_by(primarycategory_id: params[:id])
    # redirect_to categories_path
  end


  def show
    @categories = Category.find_by(id: params[:id]).secondary_categories
  end

  private

  def permit_params
    params.require(:category).permit(:category_name, :category_description, :picture)
  end
end
