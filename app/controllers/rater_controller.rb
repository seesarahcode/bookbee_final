class RaterController < ApplicationController
  before_action :set_book
  after_action :set_book_rating_avg

	include SessionsHelper
  include UsersHelper

  def create
    if signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]
      bcc_list = rating_email_list(@book)
      RatingMailer.rating_notification(bcc_list, @book).deliver
      @owner = User.find_by_id(@book.user_id)
      if receives_book_updates?(@owner)
        RatingMailer.creator_notification(@owner, @book).deliver
      end
      render :json => true
    else
      render :json => false
    end
  end

  private

  def set_book
    @book = Book.find_by_id(params[:id])
  end

  def set_book_rating_avg
    rating_obj = RatingCache.find_by_cacheable_id(@book.id)
    new_rating = rating_obj.avg
    @book.last_avg_rating = new_rating.to_s
    @book.save!
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
