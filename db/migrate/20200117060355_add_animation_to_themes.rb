class AddAnimationToThemes < ActiveRecord::Migration[6.0]
  def change
    add_column :themes, :animation, :string
  end
end
