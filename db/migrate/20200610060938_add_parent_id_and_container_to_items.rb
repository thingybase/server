class AddParentIdAndContainerToItems < ActiveRecord::Migration[6.0]
  def change
    change_table :items do |t|
      t.boolean :container, default: false
      t.index :container
      t.references :parent, foreign_key: { to_table: :items }
    end
  end
end
