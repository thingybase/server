class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels, id: :uuid do |t|
      t.string :text
      t.references :user, foreign_key: true, type: :uuid
      t.references :account, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
