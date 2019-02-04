class Item < ApplicationRecord
  include UUID

  belongs_to :account
  belongs_to :user

  validates :name, presence: true
end
