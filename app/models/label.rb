class Label < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :user, presence: true
  validates :account, presence: true
  validates :text, presence: true
  validates :uuid, presence: true, uniqueness: true

  before_validation :assign_default_uuid

  def to_param
    uuid
  end

  private
    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end
end
