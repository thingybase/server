module Accounts
  class PaymentsController < Oxidizer::NestedWeakResourceController
    layout "body"

    def create
      redirect_to checkout_session.url, status: :see_other, allow_other_host: true
    end

    def show
      session = Stripe::Checkout::Session.retrieve(params[:session_id])
      subscription = Stripe::Subscription.retrieve(session.subscription)
      @account.subscribe_from_stripe! subscription, user: current_user, plan: HomePlan
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
          success_url: success_url,
          cancel_url: new_account_payment_url(@account))
      end

      def success_url
        # Yuck! I have to do the append at the end because rails params escape the `{CHECKOUT_SESSION_ID}` values
        # to `session_id=%7BCHECKOUT_SESSION_ID%7D`. This will work though, but its def not pretty and feels a tad
        # dangerous.
        account_payment_url(@account).concat("?session_id={CHECKOUT_SESSION_ID}")
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
