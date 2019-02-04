class ContainersController < ResourcesController
  include AccountLayout

  def self.resource
    Container
  end

  def permitted_params
    [:name, :account_id, :uuid, :parent_id]
  end

  def resource_key
    :uuid
  end
end
