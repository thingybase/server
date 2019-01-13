class Label < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :user, presence: true
  validates :account, presence: true
  validates :text, presence: true
end
