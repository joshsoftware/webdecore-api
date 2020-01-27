# frozen_string_literal: true

class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.string :file
      t.string :file_type
      t.references :theme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
