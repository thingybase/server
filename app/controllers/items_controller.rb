class ItemsController < ResourcesController
  include AccountLayout

  def self.resource
    Item
  end

  def duplicate
    @item = @item.dup

    respond_to do |format|
      if resource.save
        affirm "Duplicated item"
        format.html { redirect_to create_redirect_url, notice: "#{resource_name} was successfully created." }
        format.json { render :show, status: :created, location: resource }
        create_success_formats format
      else
        format.html { render :new }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_redirect_url
    if container = @item.container
      container
    else
      items_url
    end
  end

  def permitted_params
    [:name, :account_id, :container_id, :created_at]
  end
end
