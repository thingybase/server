class Member < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :user, uniqueness: { scope: :team }
end
