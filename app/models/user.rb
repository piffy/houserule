class User < ActiveRecord::Base
  attr_accessible :description, :email, :location, :name, :nick, :password, :password_confirmation
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

  def first_name
    Regexp.new(/^(\w+)/).match(name)[0]
  end

  def first_name_or_nick
    unless self.nick.nil?  ||   self.nick.empty?
      nick
    else
      first_name
    end
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
