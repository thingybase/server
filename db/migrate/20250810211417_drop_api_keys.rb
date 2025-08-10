class DropApiKeys < ActiveRecord::Migration[8.0]
  def change
    drop_table :api_keys do |t|
      t.string :name
      t.string :secret
      t.bigint :user_id
      t.datetime :created_at, precision: nil, null: false
      t.datetime :updated_at, precision: nil, null: false
      t.index [:user_id], name: "index_api_keys_on_user_id"
    end
  end
end
