class AddColumnJsonToAnimationData < ActiveRecord::Migration[6.0]
  def change
    add_column :animation_data, :animation_json, :json
  end
end
