json.array!(@requests) do |request|
  json.extract! request, :title, :url, :date_posted, :description, :user_id
  json.url request_url(request, format: :json)
end
