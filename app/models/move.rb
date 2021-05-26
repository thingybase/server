class Move < ApplicationRecord
  include UuidField

  belongs_to :account
  belongs_to :user

  # Default container where movements will put items if a container
  # is not specified in the controller.
  belongs_to :new_item_container,
    class_name: "Item",
    optional: true

  validate :new_item_container_is_container

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

  private
    def new_item_container_is_container
      return if new_item_container.nil? or new_item_container&.container?
      errors.add :new_item_container, "must be a container"
    end
end
