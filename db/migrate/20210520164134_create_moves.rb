class CreateMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :moves do |t|
      t.references :account, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.uuid :uuid, null: false
      t.index :uuid, unique: true

      t.timestamps
    end
  end
end
