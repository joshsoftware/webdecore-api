# frozen_string_literal: true

class CreateUserAnimations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_animations do |t|
      t.date :start_date
      t.date :end_date
      t.references :user
      t.references :animation
      t.string :status

      t.timestamps
    end
  end
end
