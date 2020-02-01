# frozen_string_literal: true

class RenameStateToActiveOfThemes < ActiveRecord::Migration[6.0]
  def change
    rename_column :themes, :state, :active
  end
end
