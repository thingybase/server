# TODO: Deprecate this schema and model. It was an over-complication that proved
# to be unecessary. Here's the steps to deprecate:
#
# 1. Delegate the "code" to @item.uuid
# 2. Migrate label UUIDs to the associated item.uuid
# 3. Remove the Label model, controllers, etc. and redirect legacy
#    URLs an ItemScansController.
class Label < ApplicationRecord
  include UuidField

  belongs_to :user
  belongs_to :account
  belongs_to :item, optional: true

  validates :user, presence: true
  validates :account, presence: true

  # TODO: Drop the `text` column -- its just confusing.
  # validates :text, presence: true
  def text
    item&.name
  end

  # Eventually this should be moved into an ItemCode class, which
  # would be responsible for finding items with the same code and
  # generating new codes.
  def code(length: 6)
    item.uuid[0...length].upcase
  end

  DEFAULT_ICON_KEY = "tags".freeze

  def icon
    item ? item.icon : DEFAULT_ICON_KEY
  end
end
