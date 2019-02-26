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
end
