class AddFrequencyToUserAnimation < ActiveRecord::Migration[6.0]
  def change
    add_column :user_animations, :frequency, :integer
  end
end
