class WelcomeController < ApplicationController
  def index
    @user_count=User.count
    @event_count=Event.count

  end
end
