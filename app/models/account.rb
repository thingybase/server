class Account < ApplicationRecord
  include UuidField

  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users, through: :members, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :labels, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :member_requests
  has_one :move
  has_one :loanable_list

  validates :user, presence: true
  validates :name, presence: true
end
