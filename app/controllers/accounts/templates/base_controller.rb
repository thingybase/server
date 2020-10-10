module Accounts::Templates
  class BaseController < ResourcesController
    # Object used for form validation for account in the template controller. Also builds
    # out the item object graph of the template.
    class BaseTemplate < ApplicationModel
      validates :name, presence: true
      validates :account, presence: true

      delegate :user,
        :user=,
        :name,
        :name=,
      to: :account

      def self.policy_class
        AccountPolicy
      end

      def save
        return unless valid?

        account.transaction do
          build
          account.save!
        end
      end

      # Implement this in the subclass to build out the account.
      def build
        raise "Build not implemented", NotImplementedError
      end

      def account
        @account ||= Account.new
      end

      private
        def builder
          ItemBuilder.new(user: user, account: account, scope: account.items)
        end
    end

    protected
      def navigation_key
        "Items"
      end

      def assign_attributes
        resource.user = current_user
        assign_account_attributes
      end

      def assign_account_attributes
      end

      def create_redirect_url
        [ resource.account, :items ]
      end

      def permitted_params
        [:name]
      end

      def notice_resource_name
        "Account"
      end
  end
end
