class MenuComponent < ViewComponent::Base
  include ViewComponent::Slotable

  with_slot :item, collection: true

  def initialize(title:)
    @title = title
  end
end
