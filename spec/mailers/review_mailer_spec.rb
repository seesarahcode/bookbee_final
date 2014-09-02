require "spec_helper"

describe ReviewMailer do
  
  describe 'rating_notification' do
    before do
    	@users = ["testuser1@example.com", "testuser2@example.com"]
    	@book = Book.new(title: "American Gods", author: "Neil Gaiman", 
      isbn: "9783161484100", user_id: 101, cover: "image.jpg", 
      approved: true, deactivated: false)
    	@mail = ReviewMailer.review_notification(@users, @book)
    end
 
    it 'renders the subject' do
      expect(@mail.subject).to eql("American Gods has been reviewed on Bookbee!")
    end
 
    it 'renders the receiver email' do
      expect(@mail.bcc).to eql(@users)
    end
 
    it 'renders the sender email' do
      expect(@mail.from).to eql(["reviews@example.com"])
    end

  end

  describe 'creator_notification' do
    before do
    	@new_user = User.new(:name => "Sarah", :email=>"testuser1@example.com")
    	@book = Book.new(title: "American Gods", author: "Neil Gaiman", 
      isbn: "9783161484100", user_id: 101, cover: "image.jpg", 
      approved: true, deactivated: false)
    	@new_mail = ReviewMailer.creator_notification(@new_user, @book)
    end
 
    it 'renders the subject' do
      expect(@new_mail.subject).to eql("Your book American Gods has been reviewed on Bookbee!")
    end
 
    it 'renders the receiver email' do
      expect(@new_mail.to).to eql(["testuser1@example.com"])
    end
 
    it 'renders the sender email' do
      expect(@new_mail.from).to eql(["reviews@example.com"])
    end

  end

end