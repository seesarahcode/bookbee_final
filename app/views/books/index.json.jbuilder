json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :isbn, :last_avg_rating, :approved
  json.url book_url(book, format: :json)
end