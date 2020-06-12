class DropContainers < ActiveRecord::Migration[6.0]
  def change
    change_table :labels do |t|
      t.rename :labelable_id, :item_id
      t.remove :labelable_type
      t.index :item_id
    end

    remove_column :items, :container_id

    drop_table :containers
    drop_table :container_hierarchies
  end
end
