class LabelsController < Resourcefully::ResourcesController
  include AccountLayout
  include LabelsHelper
  skip_before_action :authorize_resource, only: :move

  def self.resource
    Label
  end

  def show
    redirect_to label_standard_url(@label)
  end

  def move
    authorize @label, :show?
  end

  def index
    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def scan
    @item = find_label
    authorize @item, :scan?
    if @item
      redirect_to @item
    else
      render :gone, status: :gone
    end
  end

  protected
    def navigation_key
      "Items"
    end

    def resource_scope
      policy_scope.joins(:user)
    end

    def permitted_params
      [:user_id, :account_id, :text, :uuid, :item_id]
    end

    def assign_attributes
      self.resource.account ||= @account
      self.resource.user = current_user
    end

    def destroy_redirect_url
      item_url @label.item
    end

    def create_success_formats(format)
      format.pdf { redirect_to resource, format: :pdf }
    end

    # This was put into place because of several bugs introduced when Brad was printing
    # off labels. When its all said and done, the labels should use the short UID from
    # `labels.uuid` field and be done via a versioned URL, like `/scans/v1/:id`
    def find_label
      resource_id = params[:uuid] || params[:id]

      case resource_id
      when /^.\d+$/ # Integer ID
        # This will be safe to remove by Jan 2021. There's only a few labels that Brad
        # has that have the integer ID. This should all be moved into a ScansController.
        raise "Remove this code path" if Time.now > Chronic.parse("Jan 1, 2021")
        resource_scope.find_by! id: resource_id
      when UuidField::GUID_REGEXP # Long GUID ID
        resource_scope.find_by! uuid: resource_id
      else # Assum its a short uid
        resource_scope.find_by! uuid: UuidField.to_long_uuid(resource_id)
      end
    end
end
