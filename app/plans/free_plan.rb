class FreePlan < ApplicationPlan
  def seats
    hard_limit quantity: account.users.count, maximum: 2
  end

  def items
    hard_limit quantity: account.items.count, maximum: 100
  end

  def magic_labels
    enabled
  end

  def custom_fields
    disabled
  end

  def upgrade
    plan HomePlan
  end
end
