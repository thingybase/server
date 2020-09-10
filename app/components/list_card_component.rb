class ListCardComponent < ViewComponent::Base
  include ViewComponent::Slotable

  with_slot :title
  with_slot :detail, collection: true

  def initialize(title, link = nil, icon: nil)
    @icon = icon
    @title = title
    @link = link
  end
end
