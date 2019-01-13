class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys, id: :uuid do |t|
      t.string :name
      t.string :secret
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
