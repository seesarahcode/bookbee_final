module BooksHelper

	def approved?(book)
		book.approved == true
	end

	def average_rating(book)
		rating = RatingCache.find_by_cacheable_id(book.id)
		rating.avg
	end

end