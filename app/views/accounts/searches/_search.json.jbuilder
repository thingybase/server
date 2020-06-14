json.items @search.items do |item|
  json.extract! item, :id, :name, :created_at, :updated_at
  json.url item_url(item)
end
json.extract! @search, :phrase, :created_at