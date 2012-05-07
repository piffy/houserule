class User < ActiveRecord::Base
  attr_accessible :description, :email, :location, :name, :nick, :password
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence   => true,
            :format     => { with: valid_email_regex },
            :uniqueness => { case_sensitive: false }


  validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6, maximum:15 }
  #validates :password_confirmation, presence: true
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

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
