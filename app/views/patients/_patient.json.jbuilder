json.extract! patient, :id, :name, :age, :gender, :county, :town, :status, :created_at, :updated_at
json.url patient_url(patient, format: :json)