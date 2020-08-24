class Label < ApplicationRecord
  include UuidField

  belongs_to :user
  belongs_to :account
  belongs_to :item, optional: true

  validates :user, presence: true
  validates :account, presence: true
  validates :text, presence: true

  DEFAULT_ICON_KEY = "tags".freeze

  def icon
    item ? item.icon : DEFAULT_ICON_KEY
  end
end
