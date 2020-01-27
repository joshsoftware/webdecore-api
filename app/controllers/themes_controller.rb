# frozen_string_literal: true

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

    @theme.state = if @theme.state == '1'
                     'Active'
                   else
                     'InActive'
                   end

    redirect_to @theme if @theme.save!
  end

  def show
    @theme = Theme.find(params[:id])
  end

  private

  def theme_params
    params.require(:theme).permit(:user_id, :theme_name, :state, :animation)
  end
end
