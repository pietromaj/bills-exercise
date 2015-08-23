json.array!(@bills) do |bill|
  json.extract! bill, :id, :avg_cost
  json.url bill_url(bill, format: :json)
end
