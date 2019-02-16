class Item < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :container, optional: true
  has_one :label, as: :labelable

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true

  def created_at=(value)
    write_attribute :created_at, Chronic.parse(value)
  end
end
