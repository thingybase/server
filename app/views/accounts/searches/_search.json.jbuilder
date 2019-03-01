json.items @search.items do |item|
  json.extract! item, :id, :name, :created_at, :updated_at
  json.url item_url(item)
end
json.containers @search.containers do |container|
  json.extract! container, :id, :name, :created_at, :updated_at
  json.url container_url(container)
end
