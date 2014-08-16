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

	# describe "index" do
 #    let(:book) { FactoryGirl.create(:book) }
 #    before(:each) do
 #      visit books_path
 #    end

 #    it { should have_title('Library') }
 #    it { should have_content('All books') }

 #    describe "pagination" do

 #      before(:all) { 30.times { FactoryGirl.create(:book) } }
 #      after(:all)  { Book.delete_all }

 #      it { should have_selector('div.pagination') }

 #      it "should list each user" do
 #        Book.paginate(page: 1).each do |book|
 #          expect(page).to have_selector('li', text: book.title)
 #        end
 #      end
 #    end
 #  end
 
# end

# in books_controller

# def index
# 	@books = Book.paginate(page: params[:book])
# end
