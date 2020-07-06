json.extract! item, :id, :name, :cost, :category, :restaurant_id, :created_at, :updated_at
json.url item_url(item, format: :json)
