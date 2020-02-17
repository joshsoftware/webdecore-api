# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = Category.primary.order(id: :ASC)
  end

  def new
    @primary_category = Category.new
    authorize @primary_category
  end

  def create
    @primary_category = Category.new(permit_params)
    if @primary_category.save
      flash[:notice] = t('create_success')
      redirect_to categories_path
    else
      flash[:alert] = t('create_error')
      redirect_to sub_categories_path(params[:id])
    end

  end

  def show
    @primary_category = Category.find_by(id: params[:id])
    if !@primary_category.nil? and @primary_category.primarycategory_id.nil?
      @categories = @primary_category.secondary_categories.order(id: :ASC)
      if @categories.empty?
        flash[:alert] = t('category_not_found')
        redirect_to categories_path
      end
    else
      flash[:alert] = t('category_not_found')
      redirect_to categories_path
    end

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
      flash[:notice] = t('create_success')
      redirect_to sub_categories_path(params[:id])
    else
      flash[:alert] = t('create_error')
      redirect_to sub_categories_path(params[:id])
    end
  end

  def edit
    @edit_primary_category = Category.find_by(id: params[:id])
    if @edit_primary_category.nil?
      flash[:alert] = t('category_not_found')
      redirect_to categories_path
    end
  end

  def update
    Category.find_by(id: params[:id]).update(permit_params)
    redirect_to categories_path
  end

  def edit_sub_category
    if Category.where(id: params[:id]).exists?
      @edit_sub_category = Category.find_by(id: params[:sub_category_id])
      if @edit_sub_category.nil?
        flash[:alert] = t('category_not_found')
        redirect_to sub_categories_path
      end
    else
      redirect_to sub_categories_path
    end
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
