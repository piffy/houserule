module EventsHelper

def update_reservation_status(event)
  return if event.nil? || event.reservations.count==0
  modified_reservations=0
  deleted_reservations=0
  max=event.max_player_num == 0 ? event.reservations.count: event.max_player_num
  max_including_wl=max+event.waiting_list

  event.reservations.each_with_index do |r,index|
    #puts index.to_s+") "+r.user.name+" -> index>max " + (index>max).to_s + " -> index>=max_wl " + (index>=max_including_wl).to_s

    if index<max && r.status!=1   #must be converted to 'confirmed'
      r.status=1
      r.save
      EventMailer.upgrade_reservation(r).deliver
      modified_reservations=modified_reservations+1
    end

    if index>=max_including_wl
      EventMailer.delete_reservation(r,r.user).deliver
      r.destroy
      deleted_reservations=deleted_reservations+1
    end

  end

  return [modified_reservations,deleted_reservations]  unless modified_reservations+deleted_reservations==0

end

end
