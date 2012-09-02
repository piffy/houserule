class Invitation < ActiveRecord::Base
  attr_accessible :accepted, :boolean, :event_id, :pending, :user_id, :valid_until
  belongs_to :event
  belongs_to :user
  validates_presence_of :user_id
  validates_presence_of :event_id
  #validates_inclusion_of :accepted, :in => [true, false]
  #validates_inclusion_of :pending, :in => [true, false]
  #validates :field, :inclusion => {:in => [true, false]}
  validates_date_of :valid_until

  scope :pending, :conditions => { :pending => true  }
  scope :not_stale, lambda { {:conditions => ["valid_until > ?", Date.today ]} }

  def expired?
    Time.parse(self.valid_until.to_s) < Time.now
  end
end
