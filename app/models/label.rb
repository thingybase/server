class Label < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :item, optional: true

  validates :user, presence: true
  validates :account, presence: true
  validates :text, presence: true
  before_validation :assign_default_uuid
  validates :uuid, presence: true, uniqueness: true

  private
    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end
end
