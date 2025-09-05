class Member < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :account, required: true

  after_commit on: [:create, :destroy] do
    Components::Account::Stats.new(account).broadcast_replace
  end

  delegate :name, to: :user

  validates_uniqueness_of :user_id, scope: :account_id
end
