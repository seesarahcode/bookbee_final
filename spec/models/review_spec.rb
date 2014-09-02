require 'spec_helper'

describe Review do
  before :each do
    @book = Book.new(title: "American Gods", author: "Neil Gaiman", 
      isbn: "9783161484100", user_id: 808, :id => 42)
    @review = @book.reviews.new(:title=>"Pretty Good", :text=> "Enjoyed it a lot.", :fave_quote=> "Quote here.", :user_id=>101, :book_id=>42)
  end

  subject { @review }

	it { should respond_to(:title) }
	it { should respond_to(:text)}
	it { should respond_to(:fave_quote) }
  it { should respond_to(:user_id) }
  it { should respond_to(:book_id) }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @review.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when book_id is not present" do
  	before { @review.book_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank title" do
  	before { @review.title = " " }
  	it { should_not be_valid }
  end

  describe "with blank text" do
  	before { @review.text = " " }
  	it { should_not be_valid }
  end
end
