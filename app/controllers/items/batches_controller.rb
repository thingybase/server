module Items
  class BatchesController < Resourcefully::NestedResourcesController
    include AccountLayout
    include ActionView::Helpers::TextHelper

    BATCH_ACTIONS = [:delete, :label]

    def self.resource
      Batch
    end

    def self.parent_resource
      Item
    end

    def delete
      selected_models_count = @batch.selected_models.count
      Batch.transaction do
        @batch.selected_models.each do |model|
          authorize model, :destroy?
          model.destroy
        end
      end

      flash[:notice] = "Deleted #{pluralize selected_models_count, "thing"}"
      respond_to do |format|
        format.html { redirect_to delete_redirect_url }
        format.json { render :show, status: :created, location: resource }
      end
    end

    def label
      labels = @batch.selected_models.map(&:find_or_create_label)

      respond_to do |format|
        format.html { redirect_to label_url(uids(labels), format: :pdf) }
        format.json { render :show, status: :created, location: resource }
      end
    end

    def create
      self.resource = resource_class.new(resource_params)

      assign_attributes
      authorize_resource

      if resource.save
        dispatch_batch_action resource.action
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: resource.errors, status: :unprocessable_entity }
        end
      end
    end

    protected
      def navigation_key
        "Items"
      end

      def delete_redirect_url
        parent_resource
      end

      def create_redirect_url
        [:item, @batch]
      end

      def uids(scope)
        scope.map(&:uid).join(",")
      end

      def create_notice
        "Updated #{pluralize resource.selected_selections.count, "thing"}"
      end

      def permitted_params
        [
          :account_id,
          :action,
          { items_attributes: [
              :uid,
              :selected
            ]
          }
        ]
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= find_account
        self.resource.scope ||= items_scope
      end

      def find_account
        parent_resource.account
      end

    private
      def dispatch_batch_action(action_name)
        return unless BATCH_ACTIONS.include? action_name.to_sym
        self.public_send action_name
      end

      def items_scope
        parent_resource.children
      end
  end
end
