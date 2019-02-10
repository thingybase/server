class AddContainerToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :container, foreign_key: true
  end
end
