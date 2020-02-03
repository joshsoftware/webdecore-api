# frozen_string_literal: true

class AddColumnToAnimationData < ActiveRecord::Migration[6.0]
  def change
    add_column :animation_data, :picture, :string
  end
end
