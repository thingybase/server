class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :subject
      t.string :message
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
