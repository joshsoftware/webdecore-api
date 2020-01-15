class ThemesController < ApplicationController

  def index
     @themes = Theme.where(user_id: current_user.id)
  end

  def new
    @theme = Theme.new
  end

  def create
    @theme = current_user.themes.new(theme_params)
    if @theme.save!
      redirect_to @theme
    else
      render 'new'
    end
  end

  def show
    if @theme = Theme.find_by(id: params[:id])
      authorize @theme
    else
      flash[:alert] = t('activerecord.exceptions.record_not_found')
      redirect_to themes_path
    end
  end

  private

    def theme_params
      params.require(:theme).permit(:user_id, :theme_name, :active ,:animation)
    end

end
