class LabelsController < ResourcesController
  include AccountLayout

  def self.resource
    Label
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        send_data label_generator.render_pdf,
          disposition: "inline",
          type: "application/pdf",
          filename: "label-#{@label.to_param}.pdf"
      end
    end
  end

  def redirect
    @label = resource_scope.find_by! uuid: params[:uuid]
    authorize @label, :show?
    redirect_to @label.labelable
  end

  protected
    def resource_scope
      policy_scope.joins(:user)
    end

    def permitted_params
      [:user_id, :account_id, :text, :uuid, :labelable_global_id]
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

  private
    def label_generator
      LabelGenerator.new text: resource.text, url: label_uuid_redirector_url(resource)
    end

    def label_uuid_redirector_url(label)
      label_url resource.uuid
    end
end
