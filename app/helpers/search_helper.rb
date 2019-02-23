module SearchHelper
  def search_field(url: nil, autofocus: nil, value: nil)
    url ||= url_for
    autofocus ||= params[:search].present?
    value ||= params[:search]

    render partial: "helpers/search_helper/search_field", locals: {
      url: url,
      autofocus: autofocus,
      value: value }
  end
end
