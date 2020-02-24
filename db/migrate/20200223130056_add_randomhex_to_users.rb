class AddRandomhexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :randomhex, :string
  end
end
