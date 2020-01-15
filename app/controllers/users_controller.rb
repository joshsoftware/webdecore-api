class UsersController < ApplicationController

  def index
     @id = current_user.id
     @user = User.find_by_id(@id)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :image)
  end

end
