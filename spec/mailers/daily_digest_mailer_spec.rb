require "spec_helper"

describe DailyDigestMailer do
  describe "send_daily_digest" do
    before do
    	@new_user = User.new(:name => "Sarah", :email=>"testuser1@example.com")
    	@mail = DailyDigestMailer.send_daily_digest(@user)
    end
 
    it 'renders the subject' do
      expect(@mail.subject).to eq ("The Bookbee Daily Digest has arrived!")
    end
 
    it 'renders the receiver email' do
      expect(@mail.to).to eq (@user.email)
    end
 
    it 'renders the sender email' do
      expect(@mail.from).to eq (["daily@example.com"])
    end

    it 'creates rating events' do
    	expect(@mail.body).to include(@rating_events)
    end

    it 'creates review events' do
    	expect(@mail.body).to include(@review_events)
    end

  end
end
