class Member < ApplicationRecord
  belongs_to :user
  belongs_to :account

  delegate :name, to: :user

  validates :account, presence: true
  validates :user, presence: true
  validates_uniqueness_of :user_id, scope: :account_id
end
