class LabelsController < ResourcesController
  include AccountLayout

  def self.resource
    Label
  end

  def resource_scope
    policy_scope.joins(:user)
  end

  def permitted_params
    [:user_id, :account_id]
  end

  def assign_attributes
    self.resource.account = @account
    self.resource.user = current_user
  end

  def destroy_redirect_url
    account_labels_url @account
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        send_data label_generator.render_pdf,
          disposition: "inline",
          type: "application/pdf",
          filename: "label-#{@label.id}.pdf"
      end
    end
  end

  private
    def label_generator
      LabelGenerator.new text: resource.text, url: url_for(resource)
    end
end
