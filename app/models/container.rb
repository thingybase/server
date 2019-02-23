class Container < ApplicationRecord
  has_closure_tree

  include PgSearch
  pg_search_scope :search_by_name, against: :name

  belongs_to :account
  belongs_to :user
  has_many :items
  has_one :label, as: :labelable

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true
end
