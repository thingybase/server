module ContainersHelper
  def container_select_values(scope, delimiter: " / ")
    flatten_containers(scope.hash_tree).map do |row|
      [
        row.map { |container| container.name }.join(delimiter),
        row.last.id
      ]
    end
    # TODO: Take a map of container => containers and map the whole
    # thing out so we get something like `foo > biz > buzz`.
    # The key is a Container and the Value is a hash of Containers. If a container
    # doesn't have a child, its an empty Hash.
  end

  private
    def flatten_containers(tree = {}, row = [], rows = [])
      row.freeze
      tree.each do |key, value|
        r = row.dup.append(key)
        rows << r
        flatten_containers(value, r, rows)
      end
      rows
    end
end
