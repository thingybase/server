class LoanableListMember < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :loanable_list, required: true

  validates_uniqueness_of :user_id, scope: :loanable_list_id
end
