class ThemesController < ApplicationController
  def new
    @user_id = current_user.id
  end

  def create
    file_data = params[:theme][:theme_json].read
    params[:theme][:theme_json] = file_data.as_json
    params[:theme][:theme_json].force_encoding("UTF-8")
    if Theme.create(permit_params)
      flash[:notice] = t('create_success')
      redirect_to themes_path
    else
      flash[:alert] = t('create_error')
      redirect_to new_theme_path
    end
  end

  def demo
    @theme_json = Theme.find_by(id: params[:theme_id])
    if (@theme_json.nil?)
      flash[:alert] = t('animation_not_found')
      redirect_to themes_path
    else
      @theme_json = @theme_json.theme_json.to_json
    end
  end

  def index
    @themes = Theme.all
  end

  private
    def permit_params
        params.require(:theme).permit(:theme_name, :picture, :theme_json, :user_id)
    end
end
