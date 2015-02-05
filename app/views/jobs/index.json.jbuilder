json.array!(@jobs) do |job|
  json.extract! job, :id, :name, :description, :employer_provides_vehicle
  json.url job_url(job, format: :json)
end
