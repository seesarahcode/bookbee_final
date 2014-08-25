json.array!(@follows) do |follow|
  json.extract! follow, :id, :user_id, :title, :ratings, :reviews, :book_id
  json.url follow_url(follow, format: :json)
end
