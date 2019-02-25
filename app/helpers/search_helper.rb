module SearchHelper
  def search_field(url: nil, autofocus: nil, value: nil, container: nil)
    url ||= url_for
    value ||= params[:search]
    autofocus ||= params[:search].present?

    container_id = params.fetch(:container_id, container&.id)

    render partial: "helpers/search_helper/search_field", locals: {
      url: url,
      autofocus: autofocus,
      value: value,
      container_id: container_id }
  end
end
