class Container < ApplicationRecord
  include Labelable
  include PgSearch::Model

  has_closure_tree dependent: :destroy

  pg_search_scope :search_by_name, against: :name

  belongs_to :account
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true
end
