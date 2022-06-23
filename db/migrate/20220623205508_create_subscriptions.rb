class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :plan_type, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
