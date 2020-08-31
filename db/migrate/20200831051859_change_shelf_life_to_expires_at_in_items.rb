class ChangeShelfLifeToExpiresAtInItems < ActiveRecord::Migration[6.0]
  def up
    add_column :items, :expires_at, :datetime
    add_index :items, :expires_at
    execute "UPDATE items SET expires_at = upper(shelf_life)"
    remove_column :items, :shelf_life
  end

  def down
    add_column :items, :shelf_life, :daterange
    execute "UPDATE items SET upper(shelf_life) = expires_at"
    remove_column :items, :expires_at
  end
end
