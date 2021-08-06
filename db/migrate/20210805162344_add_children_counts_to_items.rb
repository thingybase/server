class AddChildrenCountsToItems < ActiveRecord::Migration[6.1]
  def up
    add_column :items, :items_count, :integer, null: false, default: 0
    add_column :items, :containers_count, :integer, null: false, default: 0

    # Count all the items and set the counts.
    execute <<-SQL
      UPDATE
        items
      SET
        items_count = (
          SELECT
            COUNT(*)
          FROM
            items AS child
          WHERE
            child.container = false AND child.parent_id = items.id),

        containers_count = (
          SELECT
            COUNT(*)
          FROM
            items AS child
          WHERE
            child.container = true AND child.parent_id = items.id)
    SQL
  end

  def down
    remove_column :items, :items_count
    remove_column :items, :containers_count
  end
end
