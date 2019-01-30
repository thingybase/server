class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :text
      t.uuid :uuid, null: false
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
