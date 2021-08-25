class MemberRequest < ApplicationRecord
  belongs_to :account, required: true
  belongs_to :user, required: true

  validates_uniqueness_of :user_id, scope: :account_id
end
