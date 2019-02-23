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
        send_data label_generator(resource).render_pdf,
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
        send_data label_generator(resources).render_pdf,
          disposition: "inline",
          type: "application/pdf",
          filename: "labels.pdf"
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
    def label_generator(resources)
      LabelGenerator.new.tap do |generator|
        Array(resources).each do |r|
          lines = []
          lines << "Created #{r.labelable.created_at.to_date.to_s(:long)}" if r.labelable
          lines << r.uuid
          generator.add_label text: r.text, url: label_uuid_redirector_url(r), lines: lines
        end
      end
    end
end
