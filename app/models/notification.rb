class Notification < ApplicationRecord
  belongs_to :user
  validates :subject, presence: true
  validates :message, presence: true
end
