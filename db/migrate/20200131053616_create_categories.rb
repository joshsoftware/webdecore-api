class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
    	t.string :category_name
    	t.string :category_description
    	t.string :picture
    	t.references :primarycategory, index: true
      t.timestamps
    end
  end
end
