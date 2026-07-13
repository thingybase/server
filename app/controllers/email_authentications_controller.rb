class EmailAuthenticationsController < ApplicationController
  skip_security!

  include NoPassword::EmailAuthentication
  include Superview::Actions

  layout false

  class New < Views::Confirmation
    attr_accessor :authentication

    def cancel_url = new_session_path
    def page_title = "Sign in to Thingybase"

    def view_template
      render Components::ConfirmationCard.new do |c|
        c.header(
          title: "Get a sign-in link",
          subtitle: "Enter your email and a sign-in link will be sent to your inbox"
        )

        render Components::Form.new(@authentication) do |form|
          div(class: "join w-full") do
            render form.field(:email).input(
              type: :email,
              placeholder: "you@example.com",
              autofocus: true,
              class: "input input-bordered join-item flex-1 input-lg"
            )
            form.submit("Continue →", class: "btn btn-primary btn-lg join-item")
          end
        end
      end
    end
  end

  class Create < Views::Confirmation
    attr_accessor :authentication

    def cancel_url = new_email_authentication_path
    def page_title = "Check your email"

    def view_template
      render Components::ConfirmationCard.new do |c|
        c.header(
          title: "Check your email",
          subtitle: "A sign-in link was sent to #{@authentication.email}"
        )
        c.content do
          p { "Click the link in your email to sign in. The link expires in 10 minutes." }
          p do
            plain "Didn't receive it? Check your spam folder or "
            a(href: new_email_authentication_path, class: "link link-primary") { "try again" }
            plain "."
          end
        end
      end
    end
  end

  class Show < Views::Confirmation
    attr_accessor :verification, :authentication

    def cancel_url = new_email_authentication_path
    def page_title = "Confirm sign-in"

    def view_template
      render Components::ConfirmationCard.new do |c|
        c.header(
          title: "Confirm sign-in",
          subtitle: "#{@authentication.email} will be signed in to this browser"
        )
        render Components::Form.new(@verification) do |form|
          form.submit("Continue Sign In →", class: "btn btn-primary btn-lg w-full")
        end
      end
    end
  end

  class DifferentBrowser < Views::Confirmation
    def cancel_url = new_email_authentication_path
    def page_title = "Wrong browser"

    def view_template
      render Components::ConfirmationCard.new do |c|
        c.header(
          title: "Wrong browser",
          subtitle: "Copy this link and paste it in the browser where you requested it"
        )
        div(class: "flex flex-col gap-4") do
          button(
            class: "btn btn-primary btn-lg",
            onclick: safe("navigator.clipboard.writeText(window.location.href); this.textContent = 'Link Copied'")
          ) { "Copy Link" }
          p(class: "text-sm text-base-content/60") do
            plain "For security, sign in links only work in the browser that requested them. If you'd rather sign in to this browser, "
            a(href: new_email_authentication_path, class: "link link-primary") { "request a new link" }
            plain "."
          end
        end
      end
    end
  end

  def index
    redirect_to action: :new
  end

  def new
    render phlex
  end

  def create
    @authentication.email = authentication_params[:email]
    @authentication.return_url ||= after_authentication_url

    if @authentication.valid? && @authentication.challenge.save
      @authentication.save
      deliver_challenge(@authentication.challenge)
      render component_action(:create), status: :accepted
    else
      render component_action(:new), status: :unprocessable_entity
    end
  end

  def show
    if @verification.different_browser?
      render component(DifferentBrowser)
    else
      render component(Show)
    end
  end

  protected

  def verification_succeeded(email)
    rotate_session

    if user = User.find_by_email(email)
      self.current_user = user
      redirect_to access_denied_url || launch_url
    else
      # New emails go through signup to collect a name.
      session[:authentic_email] = email
      redirect_to new_signup_url
    end
  end

  def verification_failed(verification)
    flash.now[:alert] = verification.errors.full_messages.to_sentence
    render component(Show), status: :unprocessable_entity
  end

  def verification_different_browser(verification)
    flash.now[:alert] = verification.errors.full_messages.to_sentence
    render component(DifferentBrowser), status: :unprocessable_entity
  end

  def verification_expired(verification)
    flash[:alert] = "Link has expired. Please try again."
    redirect_to url_for(action: :new)
  end

  def after_authentication_url
    launch_url
  end
end
