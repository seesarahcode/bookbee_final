class StaticPagesController < ApplicationController
  
  def home
  	@book = current_user.books.build if signed_in?
  end

  def faq
  end

  def home
  	if signed_in?
  		@book = current_user.books.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	end
  end
  
end
