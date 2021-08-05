class AddNullConstraintToItemsContainer < ActiveRecord::Migration[6.1]
  def change
    execute "UPDATE items SET container = false WHERE container IS NULL"
    change_column_null :items, :container, false
  end
end
