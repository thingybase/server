class CreatePhoneNumberClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_number_claims do |t|
      t.string :phone_number, null: false
      t.string :code, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
