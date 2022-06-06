module LoanableListMemberRequests
  class ReviewsController < Resourcefully::NestedResourcesController
    include AccountLayout
    after_action :deliver_email_notification, only: :create

    protected
      def create_notice
        if resource.accepted?
          "Person added to list"
        else
          "Person not added to list"
        end
      end

      def create_redirect_url
        url_for resource.loanable_list
      end

      def self.parent_resource
        LoanableListMemberRequest
      end

      def self.resource
        LoanableListMemberReview
      end

      def assign_attributes
        resource.loanable_list_member_request = parent_resource
      end

      def deliver_email_notification
        return unless resource.loanable_list_member.present?
        LoanableMemberRequestMailer.account_approval_email(resource.user, current_user).deliver_now
      end

      def navigation_key
        "Borrowing"
      end

      def permitted_params
        [:status]
      end
  end
end
