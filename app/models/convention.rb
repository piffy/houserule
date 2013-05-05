class Convention < ActiveRecord::Base
  belongs_to :user
  attr_accessible :begin_date, :boolean,:user_id, :description, :end_date, :facebook_url, :image_url, :location, :name, :website_url, :linked_event_check
  validates_date_of :begin_date, :allow_nil => false
  validates_date_of :end_date, :allow_nil => false
  validates :end_date, :date => {:after_or_equal_to => :begin_date }
  validates_presence_of :user_id, :message => "deve avere un utente"
  validates_presence_of :name, :message => "non deve essere vuoto"
  validates_uniqueness_of :name, :message => "in uso" , :case_sensitive => false
  validates_presence_of :location, :message => "non deve essere vuoto"
  has_many :events

  before_destroy :unlink_events

  scope :incoming, lambda { {:conditions => ["end_date >= ?", Date.today ]} }
  scope :past, lambda { {:conditions => ["end_date < ?", Date.today ]} }
  scope :starting_after, lambda { |date| {:conditions => ["begin_date <= ?", date.midnight ]} }
  scope :ending_before, lambda { |date| {:conditions => ["end_date >= ?", date.midnight ]} }
  #scope :compatible, lambda { |time,time2| where("begin_date >= ? AND  end_date <= ?", time,time2) }

  def unlink_events
    if self.events.any?
      self.events.each do |e|
        unlink(e)
      end
    end
  end

  def compatible_with?(event)
    return false if event.begins_at.nil?
    return event.begins_at.to_date >= self.begin_date.to_date && event.begins_at.to_date <= self.end_date.to_date
  end

  def link(event)
    return false unless compatible_with?(event)
    event.location=self.location if event.location.blank?
    event.convention_id=self.id
    event.status = 4
    event.save
    return true
  end

  def unlink(event)
    event.convention_id=nil
    event.status =1
    event.save
  end

  # Returns convention image url. If it is empty, returns default icon
  def image_url_or_default
    unless self.image_url.nil?  ||   self.image_url.empty?
      image_url
    else
      '/assets/convention-icon.png'
    end
  end

end
