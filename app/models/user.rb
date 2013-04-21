#This class holds the user model, including name, password, email
#Email must be unique, whereas name can be duplicated
class User < ActiveRecord::Base
  attr_accessible :description, :email, :location, :name, :nick, :password, :password_confirmation
  has_many :events, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :reservations, dependent: :destroy, :through => :events
  has_many :invitations, dependent: :destroy
  has_many :interesting_groups, :through => :interests, :source => :group
  has_many :conventions, dependent: :destroy
  has_one  :reputation, dependent: :destroy

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence   => true,
            :format     => { with: valid_email_regex },
            :uniqueness => { case_sensitive: false }


  validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6, maximum:15 }
  validates_confirmation_of :password
  validates_presence_of :password_confirmation, :if => :password_changed?

  validates_length_of :nick, :maximum=>15

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  # Checks if password is OK
  # Return same object unless check fails
  def authenticate(pw)
    if self.password==pw
      self
    else
      false
    end

  end

  # Returns first name of user (actually, first word)
  def first_name
    Regexp.new(/^(\w+)/).match(name)[0]
  end

  # Returns user nick. If it is empty, returns first name
  def first_name_or_nick
    unless self.nick.nil?  ||   self.nick.empty?
      nick
    else
      first_name
    end
  end

  # Returns a list of the events to which the user has a reservation (plain SQL query)
  def reserved_events
    Event.find_by_sql("select events.* from events,reservations where events.id=reservations.event_id AND reservations.user_id="+self.id.to_s)
  end

  def reset_password_url
    #self.create_perishable_token
    #self.save
    "http://"+ApplicationController.hostname+"/password_resets/"+self.remember_token+"/edit"
  end
  def score
    if reputation.nil?
      return "N/A"
    else
      return reputation.score
    end
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
