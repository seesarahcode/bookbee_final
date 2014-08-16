require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    it "should have the content 'Bookbee'" do
    	visit root_path
      expect(page).to have_content('Bookbee')
    end

     describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:book, user: user, title: "American Gods", author: "Neil Gaiman", isbn: "9783161484100")
        FactoryGirl.create(:book, user: user, title: "Neverwhere", author: "Neil Gaiman", isbn: "9783161484100")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.title)
        end
      end
    end
  end

  describe "FAQ page" do
  	it "should have the title of FAQHelp" do
  		visit '/faq'
  		expect(page).to have_content('FAQ')
  	end
  end
end
