class AnnouncementsController < ApplicationController
  before_filter :logged_in_user
  before_filter :has_rights_to

  def new
    @event = Event.find(params[:event_id])
    @user = current_user
  end
  def create
    @event = Event.find(params[:event_id])
    #first case: plain email
    email_list = Array.new
    6.times do  |n|
        if params[:announcement]["email"+n.to_s].match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/)
          email_list << params[:announcement]["email"+n.to_s]
        end
    end
    @email_count=email_list.count
    @emails = email_list.join(";")
    if  @email_count>0
      #EventMailer.new_reservation(@reservation).deliver
      EventMailer.announcement(current_user, @event, email_list).deliver
      flash[:success] = "Annuncio inviato a "+@email_count.to_s+" indirizzi"
      redirect_to event_path(@event)
    else
      flash[:error] = "Non sono stati inseriti indirizzi validi"
      render 'new'
    end

  end

  private

  def has_rights_to
    e = Event.find(params[:event_id])
    unless current_user?(e.user)
      flash[:notice] = "Azione non consentita"
      redirect_to event_path(e)
    end
  end
end
