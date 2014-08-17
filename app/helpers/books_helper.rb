module BooksHelper

	def approved?(book)
		book.approved == true
	end

end