class Member < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :team, presence: true
  validates :user, presence: true
  validates_uniqueness_of :user_id, scope: :team_id
end
