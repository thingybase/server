class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :subject, null: false
      t.string :message
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
