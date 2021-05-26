class AddNewItemContainerToMoves < ActiveRecord::Migration[6.1]
  def change
    add_reference :moves, :new_item_container, null: true, foreign_key: {to_table: :items}
  end
end
