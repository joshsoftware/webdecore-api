class AddRoleRefToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :role, null: false, default:2, foreign_key: true
  end
end
