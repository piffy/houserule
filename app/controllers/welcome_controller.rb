#This class handles the home page
class WelcomeController < ApplicationController
  def index
    @user_count=User.count
    @event_count=Event.count
    @events=Event.not_begun.all(:limit=>5)
    @not_yet_started_event_count = Event.not_begun.all.count



  end
end
