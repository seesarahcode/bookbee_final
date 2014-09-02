require 'spec_helper'

describe UsersHelper do

	before do
		@user = User.new(name: "William Shakespeare", email: "shakethatthing@speare.com", password: "foolish", password_confirmation: "foolish", admin: false, id:808)
		@optout_user = User.new(name: "Bob", email: "person@example.com", password: "foolish", password_confirmation: "foolish", admin: false, id:314, receives_book_updates: false)
	end


	describe "follows_exist?" do
		it "should return false if no follows exist" do
			follows_exist?(@user).should eq false
		end
	end

	describe "receives_book_updates?" do
		it "should return true if user receives book updates" do
			receives_book_updates?(@user).should eq true
		end
		it "should return false if user doesn't want book updates" do
			receives_book_updates(@optout_user).should eq false
		end
	end

end