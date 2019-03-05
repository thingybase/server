class AddShelfLifeToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :shelf_life, :daterange
  end
end
