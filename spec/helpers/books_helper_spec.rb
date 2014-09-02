require 'spec_helper'

describe BooksHelper do

	before do
		@book = Book.new(title: "American Gods", author: "Neil Gaiman", isbn: "9783161484100", user_id: 101, cover: "image.jpg", approved: true, deactivated: false, id: 42)
	end

	describe "approved?" do
		it "should return true if the book is approved" do
			approved?(@book).should eq true
		end
	end

	describe "average_rating" do
		it "should return true a rating if one exists" do
			average_rating(@book).should eq "No ratings"
		end
	end

	describe "deactivated?" do
		it "should  return true if the book is deactivated" do
			@new_book = Book.new(title: "American Gods", author: "Neil Gaiman", isbn: "9783161484100", user_id: 101, cover: "image.jpg", 
      approved: true, deactivated: true)
			deactivated?(@new_book).should eq true
		end
	end

	describe "has_ratings?" do
		it "should return false if there are no ratings" do
			has_ratings?(@book).should eq false
		end
	end

end