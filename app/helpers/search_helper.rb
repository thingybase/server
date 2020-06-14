module SearchHelper
  def search_field(url: nil, autofocus: nil, value: nil, item: nil)
    url ||= url_for
    value ||= params[:search]
    autofocus ||= params[:search].present?

    item_id = params.fetch(:item_id, item&.id)

    render partial: "helpers/search_helper/search_field", locals: {
      url: url,
      autofocus: autofocus,
      value: value,
      item_id: item_id }
  end
end
