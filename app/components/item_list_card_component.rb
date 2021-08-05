class ItemListCardComponent < ViewComponent::Base
  include ViewComponent::Slotable

  with_collection_parameter :item
  with_slot :detail, collection: true

  attr_accessor :item

  delegate :containers_count, :items_count, to: :item

  def initialize(item:, is_parent_visible: false, link: nil)
    @item = item
    @is_parent_visible = is_parent_visible
    @link = link.nil? ? @item : link
  end

  def expires?
    @item.expires_at
  end

  def expired?
    return unless expires?
    @item.expires_at < Time.now
  end

  def expiration_tense
    expired? ? "Expired" : "Expires"
  end

  def container?
    !!@item.container
  end

  def contents
    if not container?
      "Item"
    elsif has_children_items? and has_children_containers?
      "Container has #{pluralize items_count, "item"} & #{pluralize containers_count, "container"}"
    elsif has_children_items?
      "Container has #{pluralize items_count, "item"}"
    elsif has_children_containers?
      "Container has #{pluralize containers_count, "container"}"
    else
      "Container is empty"
    end
  end

  def has_children_items?
    !items_count.zero?
  end

  def has_children_containers?
    !containers_count.zero?
  end

  def has_contents?
    has_children_items? or has_children_containers?
  end

  def is_parent_visible?
    @is_parent_visible && @item.parent
  end
end
