require 'spec_helper'

describe ApplicationHelper do

	before do
		@user = User.new(name: "William Shakespeare", email: "shakethatthing@speare.com", password: "foolish", password_confirmation: "foolish", admin: false, id:808)
		@book = Book.new(title: "American Gods", author: "Neil Gaiman", isbn: "9783161484100", user_id: 101, cover: "image.jpg", approved: true, deactivated: false, id: 42)
		@admin = User.new(name: "Jane Austen", email: "pride@prejudice.com",
  		password: "d4rcy5ucks", password_confirmation: "d4rcy5ucks", admin: true)
	end

	describe "full_title" do
		it "should return the full title if a page title exists" do
			page_title = "Profile"
			full_title(page_title).should eq "Bookbee | Profile"
		end
		it "should return the base title if no page title exists" do
			empty_title = ""
			full_title(empty_title).should eq "Bookbee"
		end
	end

	describe "current_user" do
		it "should return the current user" do
			pending
		end
	end

	describe "admin?" do
		it "should return true if the user is an admin" do
			admin?(@admin).should eq true
		end
		it "should return false if the user isn't an admin" do
			admin?(@user).should eq false
		end
	end

	describe "blocked_user?" do
		it "should return false if the user isn't blocked" do
			blocked_user?(@user).should eq false
		end
	end

	describe "following?" do
		it "should return false if the user if following the book" do			
			following?(@user, @book).should eq false
		end
	end

	describe "set_tags" do
		it "should create a tag list" do
			pending
		end
	end

end