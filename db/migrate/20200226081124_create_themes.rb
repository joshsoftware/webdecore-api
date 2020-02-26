class CreateThemes < ActiveRecord::Migration[6.0]
  def change
    create_table :themes do |t|
      t.string :theme_name
      t.string :picture
      t.json   :theme_json
      t.timestamps
    end
  end
end
