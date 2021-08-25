class CreateLoanableListMemberRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :loanable_list_member_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :loanable_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
