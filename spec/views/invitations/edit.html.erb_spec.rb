require 'spec_helper'

describe "invitations/edit" do
  before(:each) do
    @invitation = assign(:invitation, stub_model(Invitation,
      :sender_id => 1,
      :recipient_email => "MyString",
      :token => "MyString",
      :new => "MyString"
    ))
  end

  it "renders the edit invitation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", invitation_path(@invitation), "post" do
      assert_select "input#invitation_sender_id[name=?]", "invitation[sender_id]"
      assert_select "input#invitation_recipient_email[name=?]", "invitation[recipient_email]"
      assert_select "input#invitation_token[name=?]", "invitation[token]"
      assert_select "input#invitation_new[name=?]", "invitation[new]"
    end
  end
end
