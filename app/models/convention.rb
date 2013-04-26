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

  scope :incoming, lambda { {:conditions => ["begin_date >= ?", Date.today ]} }
  scope :past, lambda { {:conditions => ["end_date < ?", Date.today ]} }

  # Returns convention image url. If it is empty, returns default icon
  def image_url_or_default
    unless self.image_url.nil?  ||   self.image_url.empty?
      image_url
    else
      '/assets/convention-icon.png'
    end
  end

end
