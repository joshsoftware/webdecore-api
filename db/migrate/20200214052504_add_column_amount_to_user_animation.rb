class AddColumnAmountToUserAnimation < ActiveRecord::Migration[6.0]
  def change
    add_column :user_animations, :amount, :float
  end
end
