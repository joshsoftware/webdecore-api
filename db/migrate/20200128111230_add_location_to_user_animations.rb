# frozen_string_literal: true

class AddLocationToUserAnimations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_animations, :location, :string
  end
end
