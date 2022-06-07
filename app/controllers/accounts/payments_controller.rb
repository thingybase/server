module Accounts
  class PaymentsController < Oxidizer::NestedWeakResourceController
    layout "body"

    def self.parent_resource
      Account
    end

    def create
      redirect_to checkout_session.url
    end

    private
      def find_account
        parent_resource
      end

      def stripe_customer
        @stripe_customer ||= find_or_create_stripe_customer
      end

      def find_or_create_stripe_customer
        begin
          Stripe::Customer.retrieve(stripe_customer_id)
        # Blurg ... wish Stripe just returned a response object that's not an exception.
        rescue Stripe::InvalidRequestError => e
          case e.response.data
            in error: { code: "resource_missing" }
              Stripe::Customer.create(
                id: stripe_customer_id,
                name: current_user.name,
                email: current_user.email)
            else
              raise
          end
        end
      end

      def checkout_session
        Stripe::Checkout::Session.create(
          customer: stripe_customer,
          mode: "subscription",
          payment_method_types: ["card"],
          line_items: [{
            price: strip_price,
            quantity: 1
          }],
          metadata: {
            account_id: @account.id,
            user_id: current_user.id
          },
          success_url: account_payment_url(@account),
          cancel_url: new_account_payment_url(@account))
      end

      def strip_price
        ENV.fetch("STRIPE_ACCOUNT_PRICE")
      end

      def stripe_customer_id
        raise "nil user.id" if current_user.id.nil?

        current_user.id.to_s
      end
  end
end
