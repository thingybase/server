class Team < ApplicationRecord
  belongs_to :user
  has_many :members
  has_many :users, through: :members
end
