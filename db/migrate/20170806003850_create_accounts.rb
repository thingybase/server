class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
