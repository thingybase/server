class Movement < ApplicationRecord
  include UuidField

  delegate :account, to: :move, allow_nil: true

  belongs_to :user, required: true
  belongs_to :account, required: true
  belongs_to :move, required: true
  belongs_to :origin, class_name: "Item"
  belongs_to :destination, class_name: "Item"

  validates :origin, presence: true,
    # You can only move something once
    uniqueness: { scope: :move_id, message: "has already been packed" }
  validates :destination, presence: true

  validate :destination_is_container

  private
    def destination_is_container
      return if destination.nil? or destination&.container?
      errors.add :destination, "must be a container"
    end
end
