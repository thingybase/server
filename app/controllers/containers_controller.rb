class ContainersController < ResourcesController
  include AccountLayout

  def self.resource
    Container
  end

  def permitted_params
    [:name, :account_id, :parent_id]
  end
end
