class Event < ActiveRecord::Base
  attr_accessible :begins_at, :deadline, :descr_short, :description, :duration, :location, :max_player_num, :min_player_num, :name, :status, :system
  belongs_to :user
  validates_presence_of :user_id, :message => "deve avere un utente"
  validates_presence_of :name, :message => "non deve essere vuoto"
  validates_length_of :descr_short, :maximum=>255
  validates :max_player_num, :numericality => { :greater_than_or_equal_to => :min_player_num }
  validates :min_player_num, :numericality => { :greater_than_or_equal_to => 0 }
  validates :status, :numericality => true

  validates_date_of :begins_at
  validates :deadline, :date => {:before_or_equal_to => :begins_at }


  default_scope order: 'events.begins_at DESC'
  #named_scope :confirmed, :conditions => { :status => 2 }

  def status_to_s
    case self.status
      when 1
        "Proposto"
      when 2
        "Confermato"
      when 3
        "Sospeso"

    end
  end
end
