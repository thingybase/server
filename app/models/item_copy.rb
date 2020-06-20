class ItemCopy < ApplicationModel
  attr_accessor :number_of_copies

  validates :number_of_copies, numericality: { only_integer: true, greater_than: 0 }
  validates :item, presence: true
  validate :copyable

  delegate :account, :account_id, :user, :user=, to: :item

  def save
    return false if invalid?

    Item.transaction do
      Integer(number_of_copies).times { copies << persist_copy! }
      copies.freeze # Make sure we don't call this again and create more copies.
    end
  end

  def item
    @item ||= Item.find_by_id(@item_id)
  end

  def item=(item)
    @item_id = item&.id
    @item = item
  end

  def item_id=(item_id)
    @item = nil
    @item_id = item_id
  end

  def item_id
    @item_id ||= item&.id
  end

  def all
    copies + [ item ]
  end

  def copies
    @_copies ||= []
  end

  private

  def copyable
    errors.add(:item, "has already been copied") if copies.frozen?
  end

  def persist_copy!
    duplicate.tap(&:save!)
  end

  def duplicate
    item.dup.tap do |i|
      # Nil fields that need to remain unique and be auto-generated.
      i.id = i.uuid = nil
    end
  end
end
