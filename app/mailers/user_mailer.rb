class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite_user(invitation)
  	@user = invitation.sender_id
  	@invitee = invitation.recipient_name
  	@invitee_email = invitation.recipient_email
  	@url = 'http://example.com/signup'
  	mail(to: @invitee_email, subject: "Hey #{@invitee}, join me on Bookbee!" )
  	invitation.update_attribute(:sent_at, Time.now)
  end

end
