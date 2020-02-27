class AddColumnReferenceToTheme < ActiveRecord::Migration[6.0]
  def change
    add_reference :themes, :users, index: true
  end
end
