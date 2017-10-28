class CreateTeamInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :team_invitations do |t|
      t.string :email, null: false
      t.string :name
      t.string :token, null: false
      t.references :team, foreign_key: true
      t.datetime :expires_at
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :team_invitations, :token
  end
end
