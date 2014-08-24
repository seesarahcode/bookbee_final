require "spec_helper"

describe UserMailer do
  describe 'instructions' do
    let(:user) { mock_model User, name: 'Lucas', email: 'lucas@email.com', id: 4242 }
    let(:invitation) { mock_model Invitation, sender_id: user.id, 
    		recipient_email: "sarah@testing123.com", recipient_name: "Sarah"}
    let(:mail) { UserMailer.invite_user(invitation) }
 
    it 'renders the subject' do
      expect(mail.subject).to eql('Hey Sarah, join me on Bookbee!')
    end
 
    it 'renders the receiver email' do
      expect(mail.to).to eql([invitation.recipient_email])
    end
 
    it 'renders the sender email' do
      expect(mail.from).to eql(['noreply@example.com'])
    end
 
    it 'assigns @invitee' do
      expect(mail.body.encoded).to match(user.name)
    end
 
    it 'assigns @url' do
      expect(mail.body.encoded).to match("http://example.com/signup")
    end
  end
end
