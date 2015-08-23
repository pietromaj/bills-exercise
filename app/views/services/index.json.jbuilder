json.array!(@services) do |service|
  json.extract! service, :id, :name, :cost, :encounter_id
  json.url service_url(service, format: :json)
end
