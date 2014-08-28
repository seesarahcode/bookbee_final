class ReviewMailer < ActionMailer::Base
  
  default from: "reviews@example.com"

  def review_notification(users, book)
  	@users = users
  	@book = book
    @book_page = "http://example.com/book/#{@book.id}/"
  	mail(bcc: @users, subject: "#{@book.title} has been reviewed on Bookbee!")
  end

  def creator_notification(user, book)
  	@owner = user
  	@book = book
    @book_page = "http://example.com/book/#{@book.id}/"
  	mail(to: @owner.email, subject: "Your book #{@book.title} has been reviewed on Bookbee!")
  end

end
