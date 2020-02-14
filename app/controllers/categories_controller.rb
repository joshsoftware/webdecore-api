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

  def new_sub_category
    @new_sub_category = Category.new
    authorize @new_sub_category
    @primary_category_id = params[:id]
  end

  def create_sub_category
    @new_sub_category = Category.new(permit_params)
    @new_sub_category.primarycategory_id = params[:id]
    if @new_sub_category.save
      redirect_to sub_categories_path(params[:id])
    else
      flash[:alert] = "Error occured while creating"
      redirect_to sub_categories_path(params[:id])
    end
  end

  def edit
    @edit_primary_category = Category.find_by(id: params[:id])
  end

  def update
    Category.find_by(id: params[:id]).update(permit_params)
    redirect_to categories_path
  end

  def edit_sub_category
    @edit_sub_category = Category.find_by(id: params[:sub_category_id])
  end

  def update_sub_category
    Category.find_by(id: params[:sub_category_id]).update(permit_params)
    redirect_to sub_categories_path(params[:id])
  end

  def destroy
    Category.find_by(id: params[:id]).destroy
    redirect_to categories_path
  end

  def destroy_sub_category
   Category.find_by(id: params[:sub_category_id]).destroy
   redirect_to sub_categories_path(params[:id])
  end

  private

  def permit_params
    params.require(:category).permit(:category_name, :category_description, :picture)
  end

end
