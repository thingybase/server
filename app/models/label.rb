class Label < ApplicationRecord
  include UuidField

  belongs_to :user
  belongs_to :account
  belongs_to :item, optional: true

  validates :user, presence: true
  validates :account, presence: true
  validates :text, presence: true
end
