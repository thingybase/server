class MoveLabelUuidToItem < ActiveRecord::Migration[6.1]
  def up
    # Update items with the UUIDs for labels so we can delegate the lable UUID to the item.
    execute <<-SQL
      UPDATE
        items
      SET
        uuid = labels.uuid
      FROM
        labels
      WHERE
        labels.item_id = items.id
    SQL
  end

  def down
    # Nothing needs to be done.
  end
end
