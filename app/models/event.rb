#This Class represents the Event.
#An 'Event' is defined as an activity occuring ONCE, at a given time and a given place
#It must have an organizer at all time
class Event < ActiveRecord::Base
  attr_accessible :begins_at, :deadline, :descr_short, :description, :duration,
                  :location, :max_player_num, :min_player_num, :name, :status, :system,
                  :invite_only, :reservation_locked
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_and_belongs_to_many :groups
  #has_many :users, :through => reservations
  validates_presence_of :user_id, :message => "deve avere un utente"
  validates_presence_of :name, :message => "non deve essere vuoto"
  validates_length_of :descr_short, :maximum=>255
  validates :max_player_num, :numericality => { :greater_than_or_equal_to => :min_player_num }
  validates :min_player_num, :numericality => { :greater_than_or_equal_to => 0 }
  validates :status, :numericality => true

  validates_date_of :begins_at, :allow_nil => true
  validates_date_of :deadline, :allow_nil => true
  validates :deadline, :date => {:before_or_equal_to => :begins_at }, :allow_nil => true



  default_scope order: 'events.begins_at ASC'
  scope :all_events
  scope :not_begun, lambda { {:conditions => ["begins_at > ?", Date.today ]} }
  scope :no_date, :conditions => { :status => 0 }
  #named_scope :cheap, :conditions => { :price => 0..5 }
  #named_scope :recent, lambda { |*args| {:conditions => ["released_at > ?", (args.first || 2.weeks.ago)]} }
  #named_scope :visible, :include => :category, :conditions => { 'categories.hidden' => false }

  #Lists of all possible states (in Italian - unused in 0.1)
  def self.status_string
    %w(Indefinito Proposto Confermato Sospeso)
  end

  #Converts status to string
  def self.status_to_s
    self.status_string[self.status]
  end

  #Checks if the event has already begun
  def begun?
    begins_at > Time.now
  end

  #Checks if the event has still free places
  def full?
    max_player_num >0 && reservations.count >= max_player_num
  end

  def percentage
    if max_player_num == 0
      return  [reservations.count, 99].min
    else
      return (100*reservations.count.to_f / max_player_num).to_i
    end

  end


  #Checks if the event has already been reserved by user
  def already_reserved_by(user)

    r=Reservation.where("user_id = :user_id AND event_id = :event_id", { :user_id => user.id, :event_id => self.id } ).first

    if (r==nil)
      return false
    else
      return r
    end
  end

  #Checks if event has begun or can't be reserved anymore [NEED REFACTORING]
  def check_time
    if self.begins_at && Time.now > self.begins_at
      return 2
    end
    if self.deadline && Time.now > self.deadline
      return 3
    end
    return 0
  end

  #Checks if the event can be reserved by user [NEED REFACTORING]
  def can_be_reserved_by(user)
    if already_reserved_by(user)
      return 1
    end
    if Time.now > self.begins_at
      return 2
    end
    if !self.deadline.nil? && Time.now > self.deadline
      return 3
    end

    if self.max_player_num >0 && self.reservations.count >= self.max_player_num
      return 4
    end

    if self.invite_only?
      return 5
    end

    if self.reservation_locked?
      return 6
    end

    if self.begins_at.nil?
      return 7
    end

    return true

  end

end

