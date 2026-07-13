# frozen_string_literal: true

# Focused confirmation layout: back link top-left, wordmark top-right,
# content centered on a bg-base-200 canvas. Used by sign-in and other
# single-purpose confirmation pages.
class Views::Confirmation < Components::Base
  def around_template(&)
    render Views::Layouts::Base.new(title: page_title) do
      div(class: "min-h-screen bg-base-200 flex flex-col") do
        header(class: "flex justify-between items-center p-6") do
          a(href: cancel_url, class: "btn btn-ghost") { "← Go Back" }
          logo_template
        end

        div(class: "flex-1 flex justify-center p-6 md:p-16") do
          yield
        end
      end
    end
  end

  def page_title = "Thingybase"

  def cancel_url
    raise NotImplementedError
  end

  def logo_template
    h1(class: "font-bold text-lg") { "Thingybase" }
  end
end
