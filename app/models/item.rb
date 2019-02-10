class Item < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :container, optional: true
  has_one :label, as: :labelable

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true
end
