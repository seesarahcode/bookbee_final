require 'spec_helper'

describe "invitations/show" do
  before(:each) do
    @invitation = assign(:invitation, stub_model(Invitation,
      :sender_id => 1,
      :recipient_email => "Recipient Email",
      :token => "Token",
      :new => "New"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Recipient Email/)
    rendered.should match(/Token/)
    rendered.should match(/New/)
  end
end
