class BooksController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def index
		@books = Book.paginate(page: params[:book])
	end

	def create
		@book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "Book created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
	end

	def destroy
		@book.destroy
		redirect_to root_url
	end

	private

	def book_params
		params.require(:book).permit(:title, :author, :isbn)
	end

	def correct_user
		@book = current_user.books.find_by(id: params[:id])
		redirect_to root_url if @book.nil?
	end

end