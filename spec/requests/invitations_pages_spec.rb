require 'spec_helper'

describe "Invitations" do
  
  subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }


	describe "create invitation" do
    before do 
    	visit user_path
    end


    describe "with invalid information" do

      it "should not create a book" do
        expect { click_button "Invite Friend" }.not_to change(Invitation, :count)
      end

      describe "error messages" do
        before { click_button "Invite Friend" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
      	fill_in 'recipient_email', with: "friend@example.com" 
    		fill_in 'recipient_name', with: "Stephen King"
      end 
      it "should create a book" do
        expect { click_button "Invite Friend" }.to change(Invitation, :count).by(1)
      end
    end
  end
end
