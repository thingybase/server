class SearchFieldComponent < ApplicationComponent
  def initialize(url: nil, autofocus: nil, value: nil, button: "Search", placeholder: "Search")
    @url = url
    @value = value
    @autofocus = autofocus
    @placeholder = placeholder
  end

  def before_template
    @value ||= helpers.request.params[:search]
  end

  def view_template
    # The margins and padding are set to 0 because the browser is inexplicable
    # adding `margin-block-end` to the end of a form.
    form(action: @url, method: :get, 'data-turbo-method': :get, class: "m-0 p-0 flex flex-row") do
      div(class: "join") do
        input(type: :text, name: "search", value: @value, class: "input input-bordered join-item", autofocus: @autofocus, placeholder: @placeholder)
        input(type: :submit, class: "btn join-item", value: "Search") if @button
      end
    end
  end
end
