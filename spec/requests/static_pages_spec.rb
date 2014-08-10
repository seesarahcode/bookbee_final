require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Bookbee'" do
    	visit root_path
      expect(page).to have_content('Bookbee')
    end
  end

  describe "FAQ page" do
  	it "should have the title of FAQHelp" do
  		visit '/faq'
  		expect(page).to have_content('FAQ')
  	end
  end
end
