class Movement < ApplicationRecord
  include UuidField

  belongs_to :user, required: true
  belongs_to :account, required: true
  belongs_to :move, required: true
  belongs_to :origin, required: true,
    class_name: "Item"
  belongs_to :destination, required: true,
    class_name: "Item"

  validates :origin,
    uniqueness: {
      scope: :move_id,
      message: "has already been packed" }

  validate :destination_is_container

  private
    def destination_is_container
      return if destination.nil? or destination&.container?
      errors.add :destination, "must be a container"
    end
end
