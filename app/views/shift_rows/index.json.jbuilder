json.array!(@rows) do |row|
  json.extract! row, 
  json.url shift_row_url(row, format: :json)
end