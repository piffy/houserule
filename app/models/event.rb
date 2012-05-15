class Event < ActiveRecord::Base
  attr_accessible :begins_at, :day, :deadline, :descr_short, :description, :duration, :location, :max_player_num, :min_player_num, :name, :status, :system
  belongs_to :user
  validates_presence_of :user_id, :message => "deve avere un utente"
  validates_presence_of :name, :message => "deve avere un nome"
  validates_length_of :descr_short, :maximum=>255

  default_scope order: 'events.day DESC'
  #named_scope :confirmed, :conditions => { :status => 2 }
end
