module ItemsHelper
  def item_expiration_tense(item)
    item.shelf_life_end > Time.now ?  "Expires" : "Expired"
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
