class Movement < ApplicationRecord
  include UuidField

  delegate :account, to: :move

  belongs_to :user
  belongs_to :account
  belongs_to :move
  belongs_to :origin, class_name: "Item"
  belongs_to :destination, class_name: "Item"

  validates :user, presence: true
  validates :account, presence: true
  validates :move, presence: true
  validates :origin, presence: true,
    # You can only move something once
    uniqueness: { scope_to: :move_id, message: "has already been packed" }
  validates :destination, presence: true
end
