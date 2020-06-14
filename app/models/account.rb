class Account < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users, through: :members, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :labels, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
end
