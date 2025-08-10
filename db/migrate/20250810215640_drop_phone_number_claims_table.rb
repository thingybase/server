class DropPhoneNumberClaimsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :phone_number_claims do |t|
      t.string :phone_number, null: false
      t.string :code, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
