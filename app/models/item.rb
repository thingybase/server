class Item < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_name, against: :name

  belongs_to :account
  belongs_to :user
  belongs_to :container, optional: true
  has_one :label, as: :labelable

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true

  # TODO: Repalce this with expires_at and <strarted?>_at attributes to deal
  # with perishibles. This is bad becuase if you duplicate an item, it won't
  # carry over the created_at date.
  def created_at=(value)
    write_attribute :created_at, Chronic.parse(value, context: :past)
  end
end
