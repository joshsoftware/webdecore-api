# frozen_string_literal: true
class AnimationDatasController < ApplicationController

  def show
    @animations = AnimationData.where(category_id: params[:sub_category_id]).order(id: :ASC)

    if @animations.empty?
      flash[:alert] = t('animation_not_found')
      redirect_to sub_categories_path
    else
      sub_category = Category.find(params[:sub_category_id])
      add_breadcrumb "Category", categories_path
      add_breadcrumb sub_category.primarycategory.category_name, sub_categories_path
      add_breadcrumb sub_category.category_name
    end
    @primary_category_id = params[:id]
    @secondary_category_id = params[:sub_category_id]
  end

  def my_animations
    @animations = AnimationData.where(user_id: current_user)
    if @animations.empty?
      flash[:alert] = t('animation_not_found')
      redirect_to dashboard_index_path
    end
  end

  def demo
    # if current_user.role == 'admin'
      @animation_json = AnimationData.where(user_id: current_user).
                                      or(AnimationData.where.not(category_id: nil)).find_by(id: params[:animation_data_id])
      if (@animation_json.nil?)
        flash[:alert] = t('animation_not_found')
        redirect_to animations_path
      else
        @animation_json = @animation_json.animation_json.to_json
      end
    # else
    #   @animation_json = AnimationData.where(user_id: current_user).
    #                                   or(AnimationData.where.not(category_id: nil)).find_by(id: params[:animation_data_id])
    #   pp @animation_json
    #   if (@animation_json.nil?)
    #     flash[:alert] = t('animation_not_found')
    #     redirect_to my_animations_path
    #   else
    #     @animation_json = @animation_json.animation_json.to_json
    #   end
    # end
  end

  def new
    @new_animation = AnimationData.new
    authorize @new_animation
  end

  def create
    if current_user.role == 'user'
      file_data = params[:animation_datas][:animation_json].read
      params[:animation_datas][:animation_json] = file_data.as_json
      params[:animation_datas][:animation_json].force_encoding("UTF-8")
      params[:animation_datas][:user_id] = current_user.id
      if AnimationData.create(permit_params)
        flash[:notice] = t('create_success')
        redirect_to my_animations_path
      else
        flash[:alert] = t('create_error')
        redirect_to new_path
      end
    else
      file_data = params[:animation_datas][:animation_json].read
      params[:animation_datas][:animation_json] = file_data.as_json
      params[:animation_datas][:category_id] = params[:sub_category_id]
      params[:animation_datas][:animation_json].force_encoding("UTF-8")
      params[:animation_datas][:user_id] = current_user.id
      if AnimationData.create(permit_params)
        flash[:notice] = t('create_success')
        redirect_to animations_path
      else
        flash[:alert] = t('create_error')
        redirect_to new_animation_path
      end
    end
  end

  def edit
    @animation = AnimationData.find_by(id: params[:animation_data_id])
    if @animation.nil?
      flash[:alert] = t('animation_not_found')
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
    flash[:notice] = t('update_success')
    redirect_to animations_path
  end

  def destroy
     AnimationData.find_by(id: params[:animation_data_id]).destroy
     flash[:alert] = "Animation deleted"
     redirect_to animations_path
  end

  private
    def permit_params
      params.require(:animation_datas).permit(:animation_name, :animation_price, :category_id, :picture, :animation_json, :user_id)
    end
end
