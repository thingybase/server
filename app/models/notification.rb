class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :subject, presence: true
  validates :user, presence: true
  validates :account, presence: true

  has_one :acknowledgement, dependent: :destroy

  def name
    subject
  end
end
