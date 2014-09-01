module BooksHelper

	def approved?(book)
		book.approved == true
	end

	def average_rating(book)
		rating = RatingCache.find_by_cacheable_id(book.id)
		if rating ==nil
			"No ratings"
		else
			rating.avg
		end
	end

	def deactivated?(book)
		book.deactivated == true
	end

	def has_ratings?(book)
		if RatingCache.find_by_cacheable_id(book.id) == nil
			false
		else
			true
		end
	end

end