class InvitationsController < ApplicationController

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      UserMailer.invite_user(@invitation) 
      redirect_to root_url
      flash[:success] = "Thank you, invitation sent!"
    else
      flash[:error] = "We were not able to send the invitation. :("
      render 'new'
    end
  end

  def show
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:sender_id, :recipient_email, :recipient_name, :sent_at)
    end
end
