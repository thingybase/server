class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :subject, presence: true
  validates :user, presence: true
  validates :team, presence: true

  def name
    subject
  end
end
