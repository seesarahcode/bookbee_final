require 'spec_helper'

describe Book do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@book = Book.new(title: "American Gods", author: "Neil Gaiman", 
      isbn: "9783161484100", user_id: user.id, cover: "image.jpg")
  end

  subject { @book }

	it { should respond_to(:title) }
	it { should respond_to(:author)}
	it { should respond_to(:isbn) }
  it { should respond_to(:user_id) }
  it { should respond_to(:cover) } 
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @book.user_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank title" do
  	before { @book.title = " " }
  	it { should_not be_valid }
  end

  describe "with ISBN that is too long" do
  	before { @book.isbn = "123456789012345" }
  	it { should_not be_valid }
  end

  describe "with ISBN that is too long" do
    before { @book.isbn = "123456789012345" }
    it { should_not be_valid }
  end
end
