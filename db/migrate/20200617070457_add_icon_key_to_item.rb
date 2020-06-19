class AddIconKeyToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :icon_key, :string
  end
end
