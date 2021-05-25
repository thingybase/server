# This builder lets people quickly create moving labels (via movements)
# if they are not moving an existing item.
class MovementBuilder < ApplicationModel
  attr_accessor :name

  delegate :account, :account=,
      :user, :user=,
      :move, :move=,
      :destination, :destination=,
      :destination_id, :destination_id=,
    to: :movement

  def save
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
      Item.new(name: name, container: parent, account: account, user: user)
    end

    def parent
      nil # Root for now; we'll get this from the parent.
    end
end
