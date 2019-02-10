class ItemsController < ResourcesController
  include AccountLayout

  def self.resource
    Item
  end

  def permitted_params
    [:name, :account_id, :uuid, :container_id]
  end

  def resource_key
    :uuid
  end
end
