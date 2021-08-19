class LoanableItem < ApplicationRecord
  include UuidField

  belongs_to :loanable_list
  belongs_to :user
  belongs_to :account
  belongs_to :item

  validates :loanable_list,
    presence: true

  validates :user,
    presence: true

  validates :account,
    presence: true

  validates :item,
    presence: true,
    # An item can only appear on a list once (but it could be on many lists)
    uniqueness: { scope: :loanable_list_id, message: "is already loanable" }

  validate :item_is_not_container

  private
    def item_is_not_container
      return if item.nil? or !item&.container?
      errors.add :item, "must not be a container"
    end
end
