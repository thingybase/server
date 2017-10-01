class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.index [:user_id, :team_id], unique: true

      t.timestamps
    end
  end
end
