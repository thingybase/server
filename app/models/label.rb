class Label < ApplicationRecord
  validates :uuid, presence: true, uniqueness: true
  before_validation :assign_default_uuid

  belongs_to :user
  belongs_to :account
  belongs_to :labelable, polymorphic: true, optional: true

  validates :user, presence: true
  validates :account, presence: true
  validates :text, presence: true

  private
    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end
end
