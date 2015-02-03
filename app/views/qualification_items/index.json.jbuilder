json.array!(@qualification_items) do |qualification_item|
  json.extract! qualification_item, :id, :qualification_title, :location, :start_date, :end_date, :current
  json.url qualification_item_url(qualification_item, format: :json)
end
