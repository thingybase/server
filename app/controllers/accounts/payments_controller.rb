module Accounts
  class PaymentsController < Oxidizer::NestedWeakResourceController
    include NoCheckout::Stripe::CheckoutSession

    layout "body"

    # The upgrade page renders from ERB and posts to #create, so skip the
    # concern's behavior of creating a checkout session on #new.
    skip_before_action :assign_created_checkout_session

    def new
      # Renders app/views/accounts/payments/new.html.erb
    end

    def create
      @checkout_session = create_checkout_session
      redirect_to @checkout_session.url, status: :see_other, allow_other_host: true
    end

    def show
      unless @checkout_session&.subscription
        return redirect_to new_account_payment_url(@account), alert: "Payment was not completed"
      end

      subscription = Stripe::Subscription.retrieve(@checkout_session.subscription)
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

      def create_checkout_session
        super(
          customer: stripe_customer,
          mode: "subscription",
          payment_method_types: ["card"],
          line_items: [{
            price: stripe_price,
            quantity: 1
          }],
          metadata: {
            account_id: @account.id,
            user_id: current_user.id
          })
      end

      def stripe_price
        ENV.fetch("STRIPE_ACCOUNT_PRICE")
      end

      def stripe_customer_id
        raise "nil user.id" if current_user.id.nil?

        current_user.id.to_s
      end
  end
end
