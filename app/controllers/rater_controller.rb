class RaterController < ApplicationController
  before_action :set_book
  skip_before_filter  :verify_authenticity_token
  after_action :set_book_rating_avg, :send_individual_emails

	include SessionsHelper
  include UsersHelper

  def create
    if signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]
      bcc_list = rating_individual_email_list(@book)
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
    unless rating_obj.nil?
      new_rating = rating_obj.avg
      @book.last_avg_rating = new_rating.to_s
      @book.save!
    end
  end

  def rating_individual_email_list(book)
    # email list to return at the end
    @bcc_individual = []
    # search through every user and find
    User.all.each do |u|
      # if User has a Follow that matches this book and receives individual emails
      if following?(u, book) && u.email_frequency == :individual
        # and follow's reviews are set to true
        Follow.all.each do |f|
          if f.ratings == true
            # add to bcc
            @bcc_individual << u.email
          end
        end
      elsif following?(u, book) && u.email_frequency == :daily
        create_digest_events(book)
      end
    end
    return @bcc_individual
  end

  def following?(user, book)
    user.follows.where(book_id = book.id).exists?
  end

  def send_individual_emails
    bcc_list = rating_individual_email_list(@book)
    # for everyone 
    RatingMailer.rating_notification(bcc_list, @book).deliver
    @owner = User.find_by_id(@book.user_id)
    # Add owner to list?
    if receives_book_updates?(@owner)
      RatingMailer.creator_notification(@owner, @book).deliver
    end
  end

  def create_digest_events(book)
    # search through every user and find
    User.all.each do |u|
      # if User has a Follow that matches this book and receives daily emails
      if following?(u, book) && u.email_frequency == :daily
          # and follow's reviews are set to true
          Follow.all.each do |f|
            if f.ratings == true
              new_event = DailyDigestEvent.new(:user_id => u.id, :book_id => book.id, :update_type => :rating)
              new_event.save!
            end
          end
      end
    end
  end

end
