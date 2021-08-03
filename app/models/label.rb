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
  validate :uuid_equal_to_label_uuid

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

  private
    # TRANSITIONAL: This exists so I can get the migration out quickly that
    # changes item uuids to match label uuids.
    def assign_default_uuid
      self.uuid = item&.uuid
    end

    # TRANSITIONAL: This should never trigger, but those are always famous
    # last words with an ORM, so this acts as safety.
    def uuid_equal_to_label_uuid
      errors.add :uuid, "is not equal to item uuid" if uuid != item&.uuid
    end
end
