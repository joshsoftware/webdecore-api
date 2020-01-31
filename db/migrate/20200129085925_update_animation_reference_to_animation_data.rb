class UpdateAnimationReferenceToAnimationData < ActiveRecord::Migration[6.0]
  def change
  	rename_column :user_animations, :animation_id, :animation_data_id
  end
end
