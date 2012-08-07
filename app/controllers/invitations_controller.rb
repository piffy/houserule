#coding: utf-8
class InvitationsController < ApplicationController
  include InvitationsHelper
  before_filter :logged_in_user
  before_filter :has_rights_to , :except => [:edit, :update]
  before_filter :is_invited , :only => [:edit, :update]

  def new
    @event = Event.find(params[:event_id])
    @users = users_that_can_be_invited(@event)
    @groups = Group.all
    @invitation = Invitation.new
    @invitation.valid_until=@event.deadline
  end

  def create
    @event = Event.find(params[:event_id])
    email_list = Array.new
    #get list of selected users email
    unless params[:user_ids].nil?
      params[:user_ids].each do  |user_id|
        user=User.find_by_id(user_id)
        email_list << user.email
      end
    end

    unless params[:group_ids].nil?
      params[:group_ids].each do  |group_id|
        group=Group.find_by_id(group_id)
        email_list << group.user.email
        group.users.each do |user|
          email_list << user.email
        end
      end
    end

    email_list.uniq!
    @email_count=email_list.count
    @invites=0;
    email_list.each do |email|
      user = User.find_by_email(email)
      invitation = Invitation.new(:user_id=> user.id,
                                  :pending => true,
                                  :valid_until=>@event.deadline)
      invitation.event=@event
      if invitation.save!
        InvitationMailer.new_invitation(invitation).deliver
        @invites=@invites+1
      end


    end
    flash[:success] = @invites.to_s+" email con l'invito spedite"
    redirect_to event_invitations_path(@event)


  end

  def index
    @event = Event.find(params[:event_id])
    @invitations=Invitation.find_all_by_event_id(@event.id)
  end

  def edit
    @event = Event.find(params[:event_id])
    @invitation=Invitation.find(params[:id])
    unless @invitation.pending?
      flash[:error] = "invito già utilizzato"
      redirect_to user_path(current_user)
    end
    if @invitation.expired?
      flash[:error] = "Invito scaduto"
      redirect_to user_path(current_user)
    end

  end

  #this action is used to resend an invitation
  def show
    @event = Event.find(params[:event_id])
    @invitation=Invitation.find(params[:id])
    if @event.check_time !=0
      flash[:error] = "Impossibile rinnovare invito, troppo tardi"

    else
      @invitation.valid_until=@event.deadline
      @invitation.pending=true
      @invitation.accepted=false
      if @invitation.save
      #Re-send email
        InvitationMailer.new_invitation(@invitation,true).deliver
        flash[:success] = "Invito rinnovato sino a " +  l( @invitation.valid_until, :format => :short )
      else
        flash[:success] = "Impossibile salvare invito aggiornato"
      end
    end
    redirect_to event_invitations_path(@event)
  end

  def update
    @event = Event.find(params[:event_id])
    @invitation=Invitation.find(params[:id])
    unless @invitation.pending? &&  !@invitation.expired?
      redirect_to user_path(current_user) and return
    end
    case params[:commit]
      when "Confermo"
        @reservation = @event.reservations.build
        @reservation.user_id=@invitation.user_id
        @reservation.status=2; #confirmed
        if  @reservation.save
          @invitation.pending=false
          @invitation.accepted=true
          @invitation.save
          EventMailer.new_reservation(@reservation,@invitation).deliver
          flash[:success] = "Invito accettato e prenotazione effettuata. Mail inviata all'organizzatore ("+@event.user.name+")"
          redirect_to event_path(@event)
        else
          flash[:error] = "Impossibile prenotare"
          render 'edit'
        end
      when "Rinuncio"
        @invitation.pending=false
        @invitation.accepted=false
        @invitation.save
        InvitationMailer.deny_invitation(@invitation).deliver
        flash[:success] = "Invito rifiutato. Mail inviata all'organizzatore ("+@event.user.name+")"
        redirect_to event_path(@event)




    end
  end

  def destroy
    @invitation=Invitation.find(params[:id])
    @event = Event.find(params[:event_id])
    @interest.destroy
    flash[:success] = "Invito all'evento #{@event.name} per #{@invitation.user.name} eliminato."
    redirect_to group_path(@group)

  end


  def has_rights_to
    e = Event.find(params[:event_id])
    unless current_user?(e.user)
      flash[:notice] = "Azione non consentita"
      redirect_to event_path(e)
    end
  end

  def is_invited
    r = Invitation.find(params[:id])
    unless current_user?(r.user)
      flash[:notice] = "Azione non consentita"
      redirect_to event_path(r.event)
    end
  end

end
