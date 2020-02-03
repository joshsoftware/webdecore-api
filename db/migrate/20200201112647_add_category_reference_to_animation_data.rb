# frozen_string_literal: true

class AddCategoryReferenceToAnimationData < ActiveRecord::Migration[6.0]
  def change
    add_reference :animation_data, :category, index: true
  end
end
