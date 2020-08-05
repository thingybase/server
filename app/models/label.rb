class Label < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :item, optional: true

  validates :user, presence: true
  validates :account, presence: true
  validates :text, presence: true
  before_validation :assign_default_uuid
  validates :uuid, presence: true, uniqueness: true

  DEFAULT_ICON_KEY = "tags".freeze

  def icon
    item ? item.icon : DEFAULT_ICON_KEY
  end

  private
    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end
end
