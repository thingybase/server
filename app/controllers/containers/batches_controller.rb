module Containers
  class BatchesController < NestedResourcesController
    include AccountLayout
    include ActionView::Helpers::TextHelper

    BATCH_ACTIONS = [:delete, :label]

    def self.resource
      Batch
    end

    def self.parent_resource
      Container
    end

    def new
      super
      @items = authorize parent_resource.items
      @containers = authorize parent_resource.children
    end

    def delete
      Batch.transaction do
        @batch.selected_models.each do |model|
          authorize model, :destroy?
          model.destroy
        end
      end

      flash[:notice] = "Deleted  #{pluralize resource.selected_selections.count, "thing"}"
      respond_to do |format|
        format.html { redirect_to parent_resource }
        format.json { render :show, status: :created, location: resource }
      end
    end

    def label
      labels = @batch.selected_models.map(&:find_or_create_label)

      respond_to do |format|
        format.html { redirect_to label_url(ids(labels), format: :pdf) }
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
          format.html { render :new }
          format.json { render json: resource.errors, status: :unprocessable_entity }
        end
      end
    end

    protected
      def ids(scope)
        scope.map(&:id).join(",")
      end

      def create_notice
        "Updated #{pluralize resource.selected_selections.count, "thing"}"
      end

      def permitted_params
        [
          :account_id,
          :action,
          { items_attributes: [
              :id,
              :selected
            ]
          },
          { containers_attributes: [
              :id, :selected
            ]
          }
        ]
      end

      def create_redirect_url
        [:container, @batch]
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= parent_resource.account
        self.resource.container ||= parent_resource
      end

      def find_account
        parent_resource.account
      end

    private
      def dispatch_batch_action(action_name)
        return unless BATCH_ACTIONS.include? action_name.to_sym
        self.public_send action_name
      end
  end
end
