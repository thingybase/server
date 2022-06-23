class HomePlan < ApplicationPlan
  def seats
    hard_limit quantity: account.users.count, maximum: 6
  end

  def items
    unlimited quantity: account.items.count
  end

  def magic_labels
    enabled
  end

  def custom_fields
    enabled
  end

  def downgrade
    plan FreePlan
  end
end
