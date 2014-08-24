require 'spec_helper'

describe "invitations/index" do
  before(:each) do
    assign(:invitations, [
      stub_model(Invitation,
        :sender_id => 1,
        :recipient_email => "Recipient Email",
        :token => "Token",
        :new => "New"
      ),
      stub_model(Invitation,
        :sender_id => 1,
        :recipient_email => "Recipient Email",
        :token => "Token",
        :new => "New"
      )
    ])
  end

  it "renders a list of invitations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Recipient Email".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => "New".to_s, :count => 2
  end
end
