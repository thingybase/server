# This builder lets people quickly create moving labels (via movements)
# if they are not moving an existing item.
class MovementBuilder < ApplicationModel
  attr_accessor :name
  validates :name, presence: :true

  delegate :account, :account=,
      :user, :user=,
      :move, :move=,
      :destination, :destination=,
      :destination_id, :destination_id=,
    to: :movement

  def save
    return if invalid?

    self.class.transaction do
      item = build_item
      item.save!
      movement.origin = item
      movement.save!
    end
  end

  def movement
    @movement ||= Movement.new
  end

  def self.policy_class
    MovementPolicy
  end

  private
    def build_item
      Item.new(name: name, parent: parent, account: account, user: user)
    end

    # Default container, configured by the Move#container method.
    def parent
      move.new_item_container
    end
end
