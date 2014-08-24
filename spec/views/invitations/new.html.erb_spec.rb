require 'spec_helper'

describe "invitations/new" do
  before(:each) do
    assign(:invitation, stub_model(Invitation,
      :sender_id => 1,
      :recipient_email => "MyString",
      :token => "MyString",
      :new => "MyString"
    ).as_new_record)
  end

  it "renders new invitation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", invitations_path, "post" do
      assert_select "input#invitation_sender_id[name=?]", "invitation[sender_id]"
      assert_select "input#invitation_recipient_email[name=?]", "invitation[recipient_email]"
      assert_select "input#invitation_token[name=?]", "invitation[token]"
      assert_select "input#invitation_new[name=?]", "invitation[new]"
    end
  end
end
