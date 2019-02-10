class Item < ApplicationRecord
  include UUID

  belongs_to :account
  belongs_to :user
  belongs_to :container

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true
end
