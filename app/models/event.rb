class Event < ActiveRecord::Base
  attr_accessible :begins_at, :deadline, :descr_short, :description, :duration, :location, :max_player_num, :min_player_num, :name, :status, :system
  belongs_to :user
  has_many :reservations, dependent: :destroy
  #has_many :users, :through => reservations
  validates_presence_of :user_id, :message => "deve avere un utente"
  validates_presence_of :name, :message => "non deve essere vuoto"
  validates_length_of :descr_short, :maximum=>255
  validates :max_player_num, :numericality => { :greater_than_or_equal_to => :min_player_num }
  validates :min_player_num, :numericality => { :greater_than_or_equal_to => 0 }
  validates :status, :numericality => true

  validates_date_of :begins_at
  validates :deadline, :date => {:before_or_equal_to => :begins_at }


  default_scope order: 'events.begins_at ASC'
  scope :all_events
  scope :not_begun, lambda { {:conditions => ["begins_at > ?", Date.today ]} }
  #named_scope :confirmed, :conditions => { :status => 2 }
  #named_scope :cheap, :conditions => { :price => 0..5 }
  #named_scope :recent, lambda { |*args| {:conditions => ["released_at > ?", (args.first || 2.weeks.ago)]} }
  #named_scope :visible, :include => :category, :conditions => { 'categories.hidden' => false }


  def self.status_string
    %w(Archiviato Proposto Confermato Sospeso)
  end


  def self.status_to_s
    self.status_string[self.status]
  end

  def begun?
    begins_at > Time.now
  end


  def already_reserved_by(user)

    r=Reservation.where("user_id = :user_id AND event_id = :event_id", { :user_id => user.id, :event_id => self.id } ).first

    if (r==nil)
      return false
    else
      return r
    end
  end

  def check_time
    if Time.now > self.begins_at
      return 2
    end
    if Time.now > self.deadline
      return 3
    end
    return 0
  end

  def can_be_reserved_by(user)
    if already_reserved_by(user)
      return 1
    end
    if Time.now > self.begins_at
      return 2
    end
    if Time.now > self.deadline
      return 3
    end

    if self.max_player_num >0 && self.reservations.count >= self.max_player_num
      return 4
    end
    return true

  end

end

