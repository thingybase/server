class CreateAcknowledgements < ActiveRecord::Migration[5.1]
  def change
    create_table :acknowledgements do |t|
      t.references :user, foreign_key: true
      t.references :notification, foreign_key: true

      t.timestamps
    end
  end
end
