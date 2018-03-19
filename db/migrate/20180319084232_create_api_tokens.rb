class CreateApiTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :api_tokens do |t|
      t.string :access_id
      t.string :access_key
      t.references :user, foreign_key: true

      t.timestamps

      t.index :access_id, unique: true
    end
  end
end
