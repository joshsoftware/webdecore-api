class UpdateColumnReferenceToUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :themes, :users_id, :user_id
  end
end
