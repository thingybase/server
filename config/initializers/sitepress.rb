Sitepress.configure do |config|
  config.site.manipulate do |resource|
    # Make index the parent node.
    resource_node = resource.node
    if resource_node.name == "index"
      resource_node.parent.formats.add ext: "", asset: resource.asset
      # Removes from sibling node.
      resource_node.remove
    end
  end
end
