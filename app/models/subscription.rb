class Subscription < ApplicationRecord
  belongs_to :account, required: true
  belongs_to :user, required: true
  validates :plan, presence: :true
  validates :expires_at, presence: :true

  def plan
    plan_class&.new(account: account)
  end

  def plan=(klass)
    self.plan_type = case klass
    when Class
      klass.name
    else
      klass
    end
  end

  private
    def plan_class
      plan_type.constantize if plan_type
    end
end
