class LoanableList < ApplicationRecord
  include UuidField

  belongs_to :account
  belongs_to :user

  validates :account,
    presence: true,
    uniqueness: true # For now, we'll only allow one move per account.

  validates :user,
    presence: :true

  validates :name,
    presence: :true

  has_many :loanable_items, dependent: :destroy
  has_many :items, through: :loanable_items
end
