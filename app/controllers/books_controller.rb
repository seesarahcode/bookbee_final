class BooksController < ApplicationController
	require 'will_paginate/array'

	helper :all

	helper_method :sort_column, :sort_direction

	def index
		@books = Book.where(:approved => true)
		@books = @books.search(params[:search])
		@books = @books.sort_by(&:"#{sort_column}")
		@books = @books.reverse if sort_direction == 'DESC'
		@books = @books.paginate(:page => params[:page], :per_page => 5)
	end

	def new
		@book = Book.new
	end

	def create
		@book = current_user.books.build(book_params)
    if @book.save
    	@book.tags.each do |t|
	      tag_word = t.name.to_s
	      tag = @book.tag_words.build(:word => "#{tag_word}", :book_id => @book.id)
    		tag.save!
    	end
      flash[:success] = "Book created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
	end

	def show
		@book = Book.find(params[:id])
		@user = User.find(@book.user_id)
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
    	@book.tags.each do |t|
	      tag_word = t.name.to_s
	      tag = @book.tag_words.build(:word => "#{tag_word}", :book_id => @book.id)
    		tag.save!
    	end
      flash[:success] = "Book updated!"
      redirect_to @book
    else
      redirect_to @book, :flash => { :error => "Book could not be approved with missing fields." }
    end
  end

	def destroy
		@book = Book.find(params[:id])
		@user = User.find(@book.user_id)
		@book.destroy 
  	if current_user.admin
  		flash[:success] = "Book deleted."
  		redirect_to pending_path
  	else
  		redirect_to books_path
  	end
	end

	def pending_approval
		@books = Book.pending_approval.paginate(page: params[:book])
	end

	def user_library
		@feed_items = current_user.feed.paginate(page: params[:page])
	end

	def tagged
		if params[:tag].present?
			@books = Book.tagged_with(params[:tag])
		else
			@books = Book.postall
		end
	end

	private

	def book_params
		params.require(:book).permit(:title, :author, :isbn, 
			:cover, :remote_cover_url, :approved, :tag_list)
	end

	def sort_column
		Book.column_names.include?(params[:sort]) ? params[:sort] : "title"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end

end