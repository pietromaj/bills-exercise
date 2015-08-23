json.array!(@encounters) do |encounter|
  json.extract! encounter, :id, :patient_name, :doctor_name, :bill_id
  json.url encounter_url(encounter, format: :json)
end
