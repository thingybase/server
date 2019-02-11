class Label < ApplicationRecord
  include UUID

  belongs_to :user
  belongs_to :account
  belongs_to :labelable, polymorphic: true, optional: true

  validates :user, presence: true
  validates :account, presence: true
  validates :text, presence: true
end
