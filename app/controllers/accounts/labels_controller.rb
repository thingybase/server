module Accounts
  class LabelsController < NestedResourcesController
    include AccountLayout

    def self.resource
      Label
    end

    def self.parent_resource
      Account
    end

    def index
      respond_to do |format|
        format.html
        format.json { render template: "labels/index" }
      end
    end

    protected
      def navigation_section
        "Labels"
      end

      def resource_scope
        policy_scope.includes(:account)
      end

      def permitted_params
        [:subject, :message, :account_id, :uuid]
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= @account
      end
  end
end
