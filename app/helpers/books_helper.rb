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

	def set_tags(book)
		book.tags.each do |t|
			tag_word = t.name.to_s
			TagWord.new(:tag_word => "#{tag_word}", :book_id => book.id)
		end
	end

end