require 'spec_helper'

describe "Book pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }


	describe "book creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a book" do
        expect { click_button "Post" }.not_to change(Book, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
      	fill_in 'book_title', with: "Lorem ipsum" 
      	fill_in 'book_author', with: "Some lady"
      	fill_in 'book_isbn', with: "9783161484100"
        fill_in 'book_remote_cover_url', with: "http://kapachino.info/wp-content/uploads/2011/02/neverwhere.jpg"
      end 
      it "should create a book" do
        expect { click_button "Post" }.to change(Book, :count).by(1)
      end
    end
  end

  describe "book destruction" do
    before { FactoryGirl.create(:book, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a book" do
        expect { click_link "delete" }.to change(Book, :count).by(-1)
      end
    end
  end
end

