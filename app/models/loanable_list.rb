class LoanableList < ApplicationRecord
  include UuidField

  belongs_to :account, required: true
  belongs_to :user, required: true

  validates :account,
    presence: true,
    uniqueness: true # For now, we'll only allow one move per account.

  # Items on the list.
  has_many :loanable_items,
    dependent: :destroy
  has_many :items, through: :loanable_items

  # Access control for the loanable list to people not on the account.
  has_many :members,
    class_name: "LoanableListMember",
    dependent: :destroy
  has_many :users, through: :members

  # People who are requesting to view the list
  has_many :member_requests,
    class_name: "LoanableListMemberRequest",
    dependent: :destroy
  has_many :requesting_users, through: :member_requests, class_name: "User"
end
