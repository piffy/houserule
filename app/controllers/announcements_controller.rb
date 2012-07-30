class AnnouncementsController < ApplicationController
  before_filter :logged_in_user
  before_filter :has_rights_to, :except => [ :compose, :deliver ]

  def new
    @event = Event.find(params[:event_id])
    @user = current_user
    @groups=(@user.groups+@user.interesting_groups).uniq
    @users = User.where("id !="+current_user.id.to_s)
  end
  def create
    @event = Event.find(params[:event_id])
    @user = current_user
    @groups=(@user.groups+@user.interesting_groups).uniq
    send_cc=params[:send_cc]==1
    email_list = Array.new
    @commit=params[:commit]
    case   @commit

      when 'Invia annuncio a questi utenti'
        #second case: users
        @msg_items="utenti"

        unless params[:user_ids].nil?
          params[:user_ids].each do  |user_id|
            user=User.find_by_id(user_id)
            email_list << user.email
          end
        end

      when 'Invia annuncio ai gruppi'
          #second case: group members
          @msg_items="gruppi"
          unless params[:group_ids].nil?
            params[:group_ids].each do  |group_id|
              group=Group.find_by_id(group_id)
              email_list << group.user.email
              group.users.each do |user|
                email_list << user.email
              end
            end
          end

      when 'Invia annuncio a questi indirizzi'
          #first case: plain email
          @msg_items="indirizzi"
          6.times do  |n|
            if params[:announcement]["email"+n.to_s].match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/)
              email_list << params[:announcement]["email"+n.to_s]
            end
          end

      else
        raise "Unknown action"

    end
    email_list.uniq!
    #email_list.delete_if {|x| x == current_user.email }  unless send_cc
    @email_count=email_list.count
    @emails = email_list.join(";")
    if  @email_count>0
      #eventually remove cc: to self
      EventMailer.announcement(current_user, @event, email_list).deliver
      flash[:success] = "Annuncio inviato a "+@email_count.to_s+" indirizzi"
      redirect_to event_path(@event)
    else
      flash[:error] = "Non sono stati inseriti "+@msg_items
      @users = User.where("id !="+current_user.id.to_s)
      render 'new'
    end


  end

  #Composition of messages for members
  def compose
    @event = Event.find(params[:event_id])
    @users = []
  end

  def deliver
    @event = Event.find(params[:event_id])
    text=params[:announcement][:body]
    subject=params[:announcement][:subject] || "House Rule: messaggio relativo a: #{@event.name}"
    #case one: mail to organizer
    unless @event.user == current_user
      EventMailer.send_message(current_user, @event, @event.user.email, subject, text).deliver
      flash[:success] = "Messaggio inviato a "+@event.user.name
      redirect_to event_path(@event)
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
