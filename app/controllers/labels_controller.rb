class LabelsController < ResourcesController
  include AccountLayout
  include LabelsHelper

  def self.resource
    Label
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        send_data LabelGenerator.batch(resource, size: params[:size]).render_pdf,
          disposition: "inline",
          type: "application/pdf",
          filename: "label-#{@label.to_param}.pdf"
      end
    end
  end

  def index
    respond_to do |format|
      format.html
      format.pdf do
        send_data LabelGenerator.batch(resources, size: params[:size]).render_pdf,
          disposition: "inline",
          type: "application/pdf",
          filename: "labels.pdf"
      end
    end
  end

  def scan
    @label = resource_scope.find_by! uuid: params[:uuid]
    authorize @label, :show?
    if item = @label.item
      redirect_to item
    else
      render :gone, status: :gone
    end
  end

  protected
    def navigation_section
      "Labels"
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
      account_labels_url @account
    end

    def create_success_formats(format)
      format.pdf { redirect_to resource, format: :pdf }
    end
end
