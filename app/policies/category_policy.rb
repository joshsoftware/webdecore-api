class CategoryPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, categories)
    @user = user
    @categories = categories
  end

  def new?
    @user.role.role_name == "admin"
  end

  def new_sub_category?
    @user.role.role_name == "admin"
  end
end
