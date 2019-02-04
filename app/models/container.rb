class Container < ApplicationRecord
  has_closure_tree

  include UUID

  belongs_to :account
  belongs_to :user

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true
end
