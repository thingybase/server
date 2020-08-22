class MemberRequest < ApplicationRecord
  belongs_to :account
  belongs_to :user

  validates :account, presence: true
  validates :user, presence: true
  validates_uniqueness_of :user_id, scope: :account_id
end
