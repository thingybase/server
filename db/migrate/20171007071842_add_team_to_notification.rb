class AddTeamToNotification < ActiveRecord::Migration[5.1]
  def change
    change_table :notifications do |t|
      t.references :team
    end
  end
end
