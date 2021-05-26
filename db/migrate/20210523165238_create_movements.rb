class CreateMovements < ActiveRecord::Migration[6.1]
  def change
    create_table :movements do |t|
      t.uuid :uuid
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.references :move, null: false, foreign_key: true
      t.references :origin, null: false, foreign_key: {to_table: :items}
      t.references :destination, null: false, foreign_key: {to_table: :items}

      t.timestamps
    end
  end
end
