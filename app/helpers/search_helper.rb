module SearchHelper
  def search_field(url: url_for)
    render partial: "helpers/search_helper/search_field", locals: { url: url }
  end
end