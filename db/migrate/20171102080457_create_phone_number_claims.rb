class CreatePhoneNumberClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_number_claims, id: :uuid do |t|
      t.string :phone_number, null: false
      t.string :code, null: false
      t.references :user, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
