# frozen_string_literal: true

# Prose-width centered column used by sign-in and confirmation flows.
# Rendered inside the Views::Confirmation layout.
class Components::ConfirmationCard < Components::Base
  def initialize(confirm_url: nil, cancel_url: nil)
    @confirm_url = confirm_url
    @cancel_url = cancel_url
  end

  def header(title:, subtitle: nil) = render Components::Title.new(title:, subtitle:)
  def content(class: "prose", **, &) = div(class:, **, &)
  def confirm(&) = link_to(@confirm_url, method: :post, class: "btn btn-error", &)
  def cancel(&) = link_to(@cancel_url, class: "btn btn-outline", &)
  def done(&) = link_to(@cancel_url, class: "btn btn-primary", &)
  def actions(&) = div(class: "grid grid-cols-2 gap-4", &)

  def view_template(&)
    div(class: "w-full max-w-prose flex flex-col gap-8") do
      yield self if block_given?
    end
  end
end
