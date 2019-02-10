class Container < ApplicationRecord
  has_closure_tree

  belongs_to :account
  belongs_to :user
  has_many :items
  has_one :label, as: :labelable

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true
end
