class ItemListCardComponent < ViewComponent::Base
  include ViewComponent::Slotable

  with_collection_parameter :item
  with_slot :detail, collection: true

  def initialize(item:, is_parent_visible: false, link: nil)
    @item = item
    @is_parent_visible = is_parent_visible
    @link = link.nil? ? @item : link
  end

  def expires?
    @item.expires_at
  end

  def expiration_tense
    @item.expires_at > Time.now ?  "Expires" : "Expired"
  end

  def is_parent_visible?
    @is_parent_visible && @item.parent
  end
end
