class AddIndicesToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.index :phone_number, unique: true
      t.index :email, unique: true
    end
  end
end
