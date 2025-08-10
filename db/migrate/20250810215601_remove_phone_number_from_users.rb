class RemovePhoneNumberFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_index :users, :phone_number, if_exists: true
    remove_column :users, :phone_number, :string
  end
end