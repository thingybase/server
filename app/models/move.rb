class Move < ApplicationRecord
  include UuidField

  belongs_to :account
  belongs_to :user

  validates :account,
    presence: true,
    uniqueness: true # For now, we'll only allow one move per account.

  validates :user,
    presence: true

  has_many :movements, dependent: :destroy

  # Items that are to be moved.
  has_many :items, through: :movements,
    # When somebody asks "what am I moving", its a bunch of origins
    # which could be items or containers.
    foreign_key: :origin_id,
    source: :origin
end
