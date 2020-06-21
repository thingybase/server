class AddNullConstraintToItemsUuid < ActiveRecord::Migration[6.0]
  def change
    # If I were rails, I'd change this to `add_null_constraint` and `remove_null_constraint`,
    # below is the equiv of ADDING the constraint.
    change_column_null :items, :uuid, false
  end
end
