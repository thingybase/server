module Webhooks
  # Receives webhook callbacks from Stripe. Event handlers are inherited
  # as no-ops from NoCheckout; define methods here (e.g.
  # `customer_subscription_updated`) as lifecycle handling becomes necessary.
  class StripeWebhooksController < NoCheckout::Stripe::WebhooksController
    private
      # Read at request time instead of the gem's boot-time constant so the
      # secret can be rotated without a restart and stubbed in tests.
      def stripe_signing_secret
        ENV.fetch("STRIPE_SIGNING_SECRET")
      end
  end
end
