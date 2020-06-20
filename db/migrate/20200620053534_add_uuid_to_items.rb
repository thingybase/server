class AddUuidToItems < ActiveRecord::Migration[6.0]
  def change
    change_table :items do |t|
      t.uuid :uuid
      t.index :uuid, unique: true
    end
  end
end
