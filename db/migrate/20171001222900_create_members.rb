class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.index [:user_id, :account_id], unique: true

      t.timestamps
    end
  end
end
