class Account < ApplicationRecord
  include UuidField

  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users, through: :members, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :member_requests
  has_one :move
  has_one :loanable_list
  has_many :subscriptions

  validates :user, presence: true
  validates :name, presence: true

  broadcasts_refreshes

  def add_user(user)
    members.create!(user: user).user
  end

  def subscription
    subscriptions.order("expires_at ASC").first
  end

  def subscribe_from_stripe!(stripe, **kwargs)
    subscriptions.create! **kwargs.merge(expires_at: Time.at(stripe.current_period_end))
  end

  def plan
    subscription.present? ? subscription.plan : free_plan
  end

  def free_plan
    FreePlan.new account: self
  end
end
