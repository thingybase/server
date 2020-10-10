module AccountsHelper
  def is_active_navigation_key(key, active: true, inactive: nil, &block)
    block.call navigation_key == key ? active : inactive
  end
end
