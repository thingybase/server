# TODO: Deprecate this schema and model. It was an over-complication that proved
# to be unecessary. Here's the steps to deprecate:
#
# 1. DONE - Delegate the "code" to @item.uuid
# 2. DONE - Migrate label UUIDs to the associated item.uuid
# 3. Remove the Label model, controllers, etc. and redirect legacy
#    URLs an ItemScansController.
class Label < ApplicationModel
  attr_accessor :item, :account, :item
  delegate :uuid, :name, :created_at, :user, :account, :update_at, to: :item

  # How many digits can appear in the 5 digit code?
  CODE_LENGTH = 6

  # TODO: Drop the `text` column -- its just confusing.
  # validates :text, presence: true
  def text
    name
  end

  def uid
    UuidField.to_short_uuid uuid if uuid
  end

  def to_param
    uid
  end

  def self.find_resource(short_uuid)
    new item: Item.find_resource(short_uuid)
  end

  def self.find_resources(*short_uuids)
    Item.find_resources(*short_uuids).map.lazy { |item| new item: item }
  end

  # Eventually this should be moved into an ItemCode class, which
  # would be responsible for finding items with the same code and
  # generating new codes.
  def code(length: CODE_LENGTH)
    uuid[0...length].upcase
  end

  DEFAULT_ICON_KEY = "tags".freeze

  def icon
    item ? item.icon : DEFAULT_ICON_KEY
  end
end
