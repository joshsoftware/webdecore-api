class ThemePolicy < ApplicationPolicy
  attr_reader :user, :theme

  def initialize(user, theme)
    @user = user
    @theme = theme
  end

  def show?
    theme.user_id == @user.id
  end

  class Scope < Scope
    def resolve
      # if user.role_id?
      #  scope.all
      # end
    end
  end
end
