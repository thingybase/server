# frozen_string_literal: true

class Components::CopyEmailTemplate < Components::Base
  include Phlex::Rails::Helpers::MailTo

  def initialize(data:)
    @data = data
  end

  def view_template
    render Stimulus::Clipboard.new do |clipboard|
      div(class: "flex flex-col gap-2") do
        label(for: "email_template", class: "text-lg font-bold") { "Email template" }
        clipboard.textarea(id: "email_template", name: "email_template", class: "textarea textarea-bordered w-full", readonly: true, rows: 7) do
          @data
        end
        div(class: "help") do
          "Copy and paste this into your email app and send to people so they can request to join this account."
        end
        div(class: "flex flex-row gap-4") do
          mail_to("", "Send email", subject: "Join my account on Thingybase", body: @data, class: "btn")
          clipboard.button(class: "btn btn-outline") { "Copy template" }
        end
      end
    end
  end
end
