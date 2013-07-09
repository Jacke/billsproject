json.array!(@sites) do |site|
  json.extract! site, :name, :direction
  json.url site_url(site, format: :json)
end