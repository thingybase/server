class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number

      t.timestamps

      t.index :phone_number, unique: true
      t.index :email, unique: true
    end
  end
end
