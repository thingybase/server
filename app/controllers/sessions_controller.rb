class SessionsController < ApplicationController
  layout false

  include Superview::Actions

  # The OAuth provider's form-post callback can't carry a Rails CSRF token,
  # so authenticity verification is skipped for create only. OmniAuth's own
  # request-phase CSRF protection still applies.
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :authenticate_user, only: [:new, :create]
  skip_after_action :verify_authorized

  before_action :set_authentication, only: :new

  class OAuthLoginButton < Components::Base
    include Phlex::Rails::Helpers::FormAuthenticityToken

    def initialize(url:, label:, icon:)
      @url = url
      @label = label
      @icon = icon
    end

    def view_template
      form action: @url, method: "post", "data-turbo": "false" do
        input(
          name: "authenticity_token",
          type: "hidden",
          value: form_authenticity_token
        )

        button(class: "btn btn-lg w-full gap-2") do
          render Components::BrandIcon.new(@icon, class: "size-5")
          plain @label
        end
      end
    end
  end

  class New < Views::Confirmation
    attr_accessor :authentication

    def cancel_url = root_path
    def page_title = "Sign in to Thingybase"

    def view_template
      render Components::ConfirmationCard.new do |c|
        c.header(
          title: "Continue to your account",
          subtitle: "Sign in with your email address or your Google account"
        )

        render Components::Form.new(@authentication, action: email_authentications_path) do |form|
          div(class: "join w-full") do
            render form.field(:email).input(
              type: :email,
              placeholder: "Enter your email address",
              autofocus: true,
              class: "input input-bordered join-item flex-1 input-lg"
            )
            form.submit("Continue →", class: "btn btn-primary btn-lg join-item")
          end
        end

        hr(class: "border-base-content/10")

        render OAuthLoginButton.new(url: "/auth/google_oauth2", label: "Continue with Google", icon: :google)
      end
    end
  end

  def create
    if user = User.find_or_create_from_auth_hash(auth_hash)
      redirect_url = access_denied_url || launch_url
      reset_session # Prevents session fixation attacks
      self.current_user = user
      redirect_to redirect_url
    else
      raise "Couldn't create user from auth hash"
    end
  end

  def new
    render phlex
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  protected
    def auth_hash
      request.env['omniauth.auth']
    end

  private
    def set_authentication
      @authentication = NoPassword::Email::Authentication.new(session)
    end
end
