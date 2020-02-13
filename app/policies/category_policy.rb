class CategoryPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, categories)
    @user = user
    @categories = categories
  end

  def new?
    @user.role == "admin"
  end

  def new_sub_category?
    @user.role == "admin"
  end
end
