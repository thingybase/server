class LoanableItem < ApplicationRecord
  include UuidField

  delegate :name, to: :item

  belongs_to :loanable_list, required: true
  belongs_to :user, required: true
  belongs_to :account, required: true
  belongs_to :item, required: true

  validates :item,
    # An item can only appear on a list once (but it could be on many lists)
    uniqueness: {
      scope: :loanable_list_id,
      message: "is already loanable" }

  validate :item_is_not_container

  private
    def item_is_not_container
      return if item.nil? or !item&.container?
      errors.add :item, "must not be a container"
    end
end
