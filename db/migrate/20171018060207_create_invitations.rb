class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations, id: :uuid do |t|
      t.string :token, null: false
      t.string :email, null: false
      t.string :name
      t.references :account, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
