# frozen_string_literal: true

class ChangeStateToBeBooleanInThemes < ActiveRecord::Migration[6.0]
  def change
    change_column :themes, :state, 'boolean USING CAST(state AS boolean)'
  end
end
