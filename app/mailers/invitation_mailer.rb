class InvitationMailer < ActionMailer::Base


  #use this method to send to event owner that a new reservation has arrived
  def new_invitation(invitation,resend=false)
    @event = invitation.event
    @invitation = invitation
    @organizer = @event.user.name.capitalize
    @resend=resend
    @url=root_url(:host => ApplicationController.hostname)+edit_event_invitation_path(invitation.event,invitation)
    @event_url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    subject = "Invito per #{@event.name}"
    if resend
      subject+=" (sollecito)"
    end
    mail(:from => "noreplay.houserules@heroku.com", :to => invitation.user.email, :subject => subject )
    end

    def deny_invitation(invitation)
      @event = invitation.event
      @invitation = invitation
      @user = @invitation.user.name.capitalize
      @url=root_url(:host => ApplicationController.hostname)+edit_event_invitation_path(invitation.event,invitation)
      subject = "Invito per #{@event.name} rifiutato"
      mail(:from => "noreplay.houserules@heroku.com", :to => @event.user.email, :subject => subject )
  end

end