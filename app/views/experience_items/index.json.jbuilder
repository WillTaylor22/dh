json.array!(@experience_items) do |experience_item|
  json.extract! experience_item, :id, :job_title, :location, :description, :start_date, :end_date, :current
  json.url experience_item_url(experience_item, format: :json)
end
