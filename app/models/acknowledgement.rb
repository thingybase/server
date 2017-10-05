class Acknowledgement < ApplicationRecord
  belongs_to :user
  belongs_to :notification

  validates :user, presence: true
  validates :notification, presence: true
end
