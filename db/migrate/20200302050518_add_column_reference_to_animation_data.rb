class AddColumnReferenceToAnimationData < ActiveRecord::Migration[6.0]
  def change
    add_reference :animation_data, :user, index: true
  end
end
