class Team < ApplicationRecord
  belongs_to :user
  has_many :members
  has_many :users, through: :members
  has_many :invitations, class_name: "Invitation"
  has_many :notifications

  validates :user, presence: true
  validates :name, presence: true
end
