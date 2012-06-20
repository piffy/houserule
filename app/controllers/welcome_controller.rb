class WelcomeController < ApplicationController
  def index
    @user_count=User.count
    @event_count=Event.count
    @events=Event.all(:conditions => ["begins_at >= ?", Date.today], :limit=>5)



  end
end
