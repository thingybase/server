class CreateContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :containers do |t|
      t.string :name, null: false
      t.uuid :uuid, null: false
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true
      t.references :parent, foreign_key: { to_table: :containers }

      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
