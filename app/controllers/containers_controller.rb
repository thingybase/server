class ContainersController < ResourcesController
  include AccountLayout

  def self.resource
    Container
  end

  def destroy_redirect_url
    if parent = @container.parent
      parent
    else
      account_containers_url(@container.account)
    end
  end

  def permitted_params
    [:name, :account_id, :parent_id]
  end
end
