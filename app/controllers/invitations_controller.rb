class InvitationsController < ApplicationController
  include InvitationsHelper
  before_filter :logged_in_user
  before_filter :has_rights_to

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
      invitation.save!
      #invitation.update_attributes(params[:invitation])

    end
    redirect_to event_invitations_path(@event)


  end

  def index
    @event = Event.find(params[:event_id])
    @invitations=Invitation.find_all_by_event_id(@event.id)
  end

  def update
  end

  def destroy
  end


  def has_rights_to
    e = Event.find(params[:event_id])
    unless current_user?(e.user)
      flash[:notice] = "Azione non consentita"
      redirect_to event_path(e)
    end
  end
end
