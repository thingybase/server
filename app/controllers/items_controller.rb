class ItemsController < ResourcesController
  include AccountLayout

  def self.resource
    Item
  end

  def permitted_params
    [:name, :account_id, :container_id, :created_at]
  end
end
