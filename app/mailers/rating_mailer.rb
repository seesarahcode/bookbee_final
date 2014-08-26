class RatingMailer < ActionMailer::Base

  default from: "ratings@example.com"

  def rating_notification(users, book)
  	@users = users
  	@book = book
    @book_page = "http://example.com/book/#{@book.id}/"
    #@bcc = rating_email_list(@book)
  	mail(bcc: @users, subject: "#{@book.title} has been rated on Bookbee!")
  end

end
