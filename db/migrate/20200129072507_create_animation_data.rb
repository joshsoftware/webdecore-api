class CreateAnimationData < ActiveRecord::Migration[6.0]
  def change
    create_table :animation_data do |t|
    	t.string :animation_name
    	t.float :animation_price
    	t.references :secondary_categories
      t.timestamps
    end
  end
end
