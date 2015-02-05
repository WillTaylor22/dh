json.array!(@categories) do |category|
  json.extract! category, :id, :vehicle, :name_of_user, :description
  json.url category_url(category, format: :json)
end
