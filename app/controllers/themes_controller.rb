class ThemesController < ApplicationController

  def index
    @themes = Theme.where(user_id: current_user.id)
    # binding.pry
    # @themes = Theme.all
  end

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user_id = current_user.id

    if @theme.state == "1"
      @theme.state = "Active"
    else
      @theme.state = "InActive"
    end

    if @theme.save!
      redirect_to @theme
    end
  end

  def show
    @theme = Theme.find(params[:id])
  end

  private
    def theme_params
      params.require(:theme).permit(:user_id, :theme_name, :state ,:animation)
    end
end
