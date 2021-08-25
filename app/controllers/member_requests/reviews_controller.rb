module MemberRequests
  class ReviewsController < NestedResourcesController
    include AccountLayout
    after_action :deliver_email_notification, only: :create

    protected
      def create_notice
        if resource.accepted?
          "Person added to account"
        else
          "Person not added to account"
        end
      end

      def create_redirect_url
        account_people_url(@account)
      end

      def self.parent_resource
        MemberRequest
      end

      def self.resource
        MemberReview
      end

      def assign_attributes
        resource.member_request = parent_resource
      end

      def deliver_email_notification
        return unless resource.member.present?
        MemberRequestMailer.account_approval_email(resource.member, current_user).deliver_now
      end

      def navigation_key
        "People"
      end

      def permitted_params
        [:status]
      end
  end
end
