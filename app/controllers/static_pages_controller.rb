class StaticPagesController < ApplicationController

  def faq
  end

  def home
  	if signed_in?
      @book = current_user.books.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
end
