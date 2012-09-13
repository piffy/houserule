#This class handles the home page
class WelcomeController < ApplicationController
  before_filter :admin_only,   except: [:index]


  def index
    @user_count=User.count
    @event_count=Event.count
    @group_count=Group.count
    @events=Event.not_begun.all(:limit=>5)
    @not_yet_started_event_count = Event.not_begun.all.count
    @undefined_events=Event.no_date.all(:limit=>5)
    @undefined_event_count=Event.no_date.all.count



  end


  def administration
    @user_count=User.count
    @event_count=Event.count
    @group_count=Group.count
    @total_rows_percentage=(@user_count+@event_count+@group_count+Interest.count+Invitation.count)
    #@total_rows_percentage = (@total_rows_percentage*1000).to_i
  end

  def wall
  end

  def deliver
    text=params[:welcome][:body]
    subject=params[:welcome][:subject]
    count=0;
    if text.blank? || subject.blank?
      redirect_to welcome_wall_path and return
    end
    User.all.each do  |user|
      unless current_user?(user)
        EventMailer.send_admin_message(current_user, user.email, subject, text).deliver
        count=count+1
      end
    end
    flash[:success] = count.to_s + ((count==1)?" messaggio inviato": " messaggi inviati")
    redirect_to root_path
  end

end


private

def admin_only
  unless !current_user.nil? && current_user.admin?
    flash[:notice] = "Azione non consentita"
    redirect_to(root_path)
  end
end