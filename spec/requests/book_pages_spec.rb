# require 'spec_helper'

# describe "Book pages" do
	
# 	subject { page }

# 	describe "index" do
#     let(:book) { FactoryGirl.create(:book) }
#     before(:each) do
#       visit books_path
#     end

#     it { should have_title('Library') }
#     it { should have_content('All books') }

#     describe "pagination" do

#       before(:all) { 30.times { FactoryGirl.create(:book) } }
#       after(:all)  { Book.delete_all }

#       it { should have_selector('div.pagination') }

#       it "should list each user" do
#         Book.paginate(page: 1).each do |book|
#           expect(page).to have_selector('li', text: book.title)
#         end
#       end
#     end
#   end
 
# end

# in books_controller

# def index
# 	@books = Book.paginate(page: params[:book])
# end
