class EventWizardController < ApplicationController
  before_filter :logged_in_user
  include Wicked::Wizard
  steps :game, :when_where, :final

  def show
    @event = Event.find(params[:event_id])
    @system_list=Event.all(:select => "system").uniq.map(&:system).delete_if {|x| x == nil || x == ""}
    @location_list = (Group.all(:select => "location")+User.all(:select => "Location")+Event.all(:select => "Location")).map(&:location).delete_if {|x| x == nil || x == ""}
    @no_date=@event.begins_at.nil?
    if @no_date and step != :game
      @event.begins_at=Time.now+7.days
      flash.now[:notice]="Questo evento non ha ancora una data stabilita"
    end

    @no_deadline= @event.deadline.nil?  ||     @event.deadline == @event.begins_at
    @event.deadline=@event.begins_at if @no_deadline
    render_wizard
  end

  def update
    @event = Event.find(params[:event_id])
    case step
      when :when_where
        datepicker_adapter
        if params[:date_type]=="STANDARD"
          @event.status=1 if @event.status==0
        end
        if params[:date_type]=="NODEADLINE"
          @event.status=1 if @event.status==0
          @event.deadline=@event.begins_at
          delete_dates_from_parms(false)
        end
        if params[:date_type]=="NODATE"
          @event.status=0
          @event.deadline=@event.begins_at=nil
          delete_dates_from_parms(true)
          delete_all_invites_and_reservations(@event)
          flash[:notice]="Tutti gli inviti e le prenotazioni sono stati cancellati"
        end
      when :game
        if  @event.reservations.count!=0

          #case max player num set to 0
          max=@event.max_player_num == 0 ? (2**(0.size * 8 -2) -1) : @event.max_player_num-1
          modified_reservations=0
          deleted_reservations=0

          @event.reservations.each_with_index do |r,index|
            puts index.to_s+") "+r.user.name+" -> index>max" + (index>max).to_s
            if index<=max && r.status!=1
              #Convert to confirmed
              r.status=1
              r.save
              EventMailer.new_reservation(r).deliver
              puts index.to_s+") "+r.user.name+" -> CONFIRMED"
              modified_reservations=modified_reservations+1

            end
            if r.status!=2 && index>max &&  index<max+params[:event][:max_player_num].to_i && params[:event][:max_player_num].to_i>0
              #Convert to waiting list
              r.status=2
              r.save
              EventMailer.new_reservation(r,nil,true).deliver
              puts index.to_s+") "+r.user.name+" -> Waiting List"
              modified_reservations=modified_reservations+1
            end
            if index>max+params[:event][:max_player_num].to_i
              EventMailer.delete_reservation(r,current_user).deliver
              r.destroy
              puts index.to_s+") "+r.user.name+"DELETED"
              modified_reservations=modified_reservations+1
            end

          end
          flash[:notice]="#{modified_reservations} prenotazioni modificate o cancellate" if modified_reservations>0
=begin
          if seat_balance == 0
            n=trim_reservations_by(@event,@event.waiting_list-params[:event][:waiting_list].to_i)
            flash[:notice]="#{n} prenotazioni cancellate" if n>0
          end
=end
        end
    end

    @event.update_attributes(params[:event])
    render_wizard @event

  end

  private
  def trim_reservations_by(event,num)
    #puts "NUM:"+num.to_s
    return 0 if num<1
    event.reservations.slice(-num,num).each do |r|
      #puts "CANCELLAZIONE DI prenotazione di " + r.user.name
      EventMailer.delete_reservation(r,current_user).deliver
      r.destroy
    end
    return num

  end

  def delete_all_invites_and_reservations(event)
    list=Array.new
    if event.invitations.any?
      event.invitations.each do |invitation|
        list << invitation.user.email
        invitation.destroy
      end
    end
    if event.reservations.any?
      event.reservations.each do |reservation|
        list << reservation.user.email
        reservation.destroy
      end
    end
    #list.each do  |email|
    #  EventMailer.send_message(event.user, event, email, "House Rule: modifica importante in "+@event.name, "changed_date").deliver
    #end
    if list.count >0
      EventMailer.send_message(event.user, event, list.join(";"), "House Rule: modifica importante in "+@event.name, "changed_date").deliver
    end
  end

  def finish_wizard_path
    flash[:success]="Evento modificato con successo"
    event_path(Event.find(params[:event_id]))
  end


  def delete_dates_from_parms(both)
    1.upto(5) { |i|   params[:event].delete("deadline(#{i}i)") }
    if both
      1.upto(5) { |i|   params[:event].delete("begins_at(#{i}i)") }
    end
  end

  def datepicker_adapter
    if params[:event][:"begins_at_date_only"]
      /(\d\d)-(\d\d)-(\d\d\d\d)/ =~ params[:event]["begins_at_date_only"]
      params[:event][:"begins_at(1i)"]=Regexp.last_match[3]
      params[:event][:"begins_at(2i)"]=Regexp.last_match[2]
      params[:event][:"begins_at(3i)"]=Regexp.last_match[1]
      /(\d\d)-(\d\d)-(\d\d\d\d)/ =~ params[:event]["deadline_date_only"]
      params[:event][:"deadline(1i)"]=Regexp.last_match[3]
      params[:event][:"deadline(2i)"]=Regexp.last_match[2]
      params[:event][:"deadline(3i)"]=Regexp.last_match[1]
      params[:event].delete("begins_at_date_only")
      params[:event].delete("deadline_date_only")
    end
  end

end
