class WelcomeController < ApplicationController
  def index
    @user_count=User.count
    @event_count=Event.count
    @events=Event.all(:limit=>5)


  end
end
