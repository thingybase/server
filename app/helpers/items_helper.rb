module ItemsHelper
  def item_expiration_tense(item)
    item.expires_at > Time.now ?  "Expires" : "Expired"
  end

  def render_item_list_card(item, &block)
    if block
      render layout: "items/list-card--item", locals: { item: item }, &block
    else
      render partial: "items/list-card--item", locals: { item: item }
    end
  end

  def item_select_values(scope, delimiter: " / ")
    flatten_items(scope.hash_tree).map do |row|
      [
        row.map { |item| item.name }.join(delimiter),
        row.last.id
      ]
    end
    # TODO: Take a map of item => items and map the whole
    # thing out so we get something like `foo > biz > buzz`.
    # The key is a Container and the Value is a hash of Containers. If a item
    # doesn't have a child, its an empty Hash.
  end

  # If we don't do this and the icon is an error, an exception would be thrown
  # because the icon isn't found. This just grabs the old icon value so we can
  # fix the problem and move on.
  def item_edit_icon(item)
    item.icon
  rescue
    item.icon_key_was
  end

  private
    def flatten_items(tree = {}, row = [], rows = [])
      row.freeze
      tree.each do |key, value|
        r = row.dup.append(key)
        rows << r
        flatten_items(value, r, rows)
      end
      rows
    end
end
