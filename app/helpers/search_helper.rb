module SearchHelper
  def search_field(url: nil, autofocus: nil)
    url ||= url_for
    autofocus ||= params[:search].present?

    render partial: "helpers/search_helper/search_field", locals: { url: url, autofocus: autofocus }
  end
end