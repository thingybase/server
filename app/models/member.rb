class Member < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :account, required: true, touch: true
  broadcasts_refreshes

  delegate :name, to: :user

  validates_uniqueness_of :user_id, scope: :account_id
end
