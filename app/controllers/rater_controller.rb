class RaterController < ApplicationController

  before_action :set_book

	include SessionsHelper

  def create
    if signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]
      bcc_list = rating_email_list(@book)
      RatingMailer.rating_notification(bcc_list, @book).deliver
      render :json => true

    else
      render :json => false
    end
  end

  private

  def set_book
    @book = Book.find_by_id(params[:id])
  end

  def rating_email_list(book)
    # email list to return at the end
    @bcc = []
    # search through every user and find
    User.all.each do |u|
      # if User has a Follow that matches this book
      if following?(u, book)
      # and follow's rating is set to true
        Follow.all.each do |f|
          if f.ratings == true
            # add to bcc
            @bcc << u.email
          end
        end
      end
    end
    return @bcc
  end

  def following?(user, book)
    user.follows.where(book_id = book.id).exists?
  end

end
