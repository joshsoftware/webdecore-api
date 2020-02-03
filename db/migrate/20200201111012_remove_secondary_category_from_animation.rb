# frozen_string_literal: true

class RemoveSecondaryCategoryFromAnimation < ActiveRecord::Migration[6.0]
  def change
    remove_reference :animation_data, :categories, index: true
  end
end
