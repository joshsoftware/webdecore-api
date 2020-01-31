class UpdateReferenceToCategoryId < ActiveRecord::Migration[6.0]
  def change
  	rename_column :animation_data, :secondary_categories_id, :categories_id
  end
end
