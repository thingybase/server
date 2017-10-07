class Team < ApplicationRecord
  belongs_to :user
  has_many :members
  has_many :users, through: :members

  validates :user, presence: true
  validates :name, presence: true
end
