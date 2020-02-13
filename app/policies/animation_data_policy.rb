class AnimationDataPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, animation_datas)
    @user = user
    @animation_datas = animation_datas
  end

  def new?
    @user.role == "admin"
  end
end
