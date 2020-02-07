class CategoryPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, categories)
    @user = user
    @categories = categories
  end

  def new?
    Role.find_by(id: @user.role_id).role_name == "admin"
  end

end
