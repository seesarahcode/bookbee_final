require 'spec_helper'

describe Invitation do
  before do
    @invitation = Invitation.new(:sender_id => 101, :recipient_name => "Sarah", :recipient_email => "test@testing.com", :sent_at => Time.now)
  end

	it { should respond_to(:sender_id) }
	it { should respond_to(:recipient_name)}
	it { should respond_to(:recipient_email) }
  it { should respond_to(:sent_at) }
  it { should be_valid }
  

  describe "when recipient email is not present" do
  	before { @invitation.recipient_email = nil }
  	it { should_not be_valid }
  end

  describe "when recipient name is not present" do
    before { @invitation.recipient_name = nil }
    it { should_not be_valid }
  end

end
