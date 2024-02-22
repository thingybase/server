class SearchFieldComponent < ApplicationComponent
  def initialize(url: nil, autofocus: nil, value: nil, item: nil, button: "Search", placeholder: nil)
    @url = url
    @value = value
    @autofocus = autofocus
    @item = item
  end

  def before_template
    @url ||= url_for
    @value ||= helpers.request.params[:search]
    @autofocus ||= helpers.request.params[:search].present?
    # url ||= url_for
    # value ||= params[:search]
    # autofocus ||= params[:search].present?
    # item_id = params.fetch(:item_id, item&.id)
  end

  def placeholder_text
    return unless @item
    if @item.root?
      "Search"
    else
      "Search #{@item.name}"
    end
  end

  def template
    # The margins and padding are set to 0 because the browser is inexplicable
    # adding `margin-block-end` to the end of a form.
    form(action: (@url || url_for), method: :get, class: "m-0 p-0 flex flex-row") do
      div(class: "join") do
        input(type: :hidden, name: :item_id, value: @item_id) if @item_id
        input(type: :text, name: @search, value: @value, class: "input input-bordered join-item", autofocus: @autofocus, placeholder: placeholder_text)
        input(type: :submit, class: "btn join-item", value: "Search") if @button
      end
    end
  end
end
