class CreateMemberRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :member_requests do |t|
      t.references :account
      t.references :user
      t.index [ :account_id, :user_id ], unique: true

      t.timestamps
    end
  end
end
