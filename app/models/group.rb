class Group < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :image_url, :location, :name, :website_url
  validates :name, presence: true, :uniqueness => { case_sensitive: false }
  before_validation :smart_add_url_protocol
  has_many :interests, dependent: :destroy

  valid_url_regex_or_empty = /^$|(^((http|https):\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]*)+.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :image_url,  :format     => { with: valid_url_regex_or_empty }
  validates :website_url,:format     => { with: valid_url_regex_or_empty }

  # Returns group image url. If it is empty, returns default icon
  def image_url_or_default
    unless self.image_url.nil?  ||   self.image_url.empty?
      image_url
    else
      "/assets/user-group-icon.png"
    end
  end



  protected
  # Adds 'http://' to URL if forgotten
  def smart_add_url_protocol
    unless  self.website_url.nil? || self.website_url.blank? || self.website_url[/^https?:\/\//]
      self.website_url = 'http://' + self.website_url
    end
    unless  self.image_url.nil? || self.image_url.blank? || self.image_url[/^https?:\/\//]
      self.image_url = 'http://' + self.image_url
    end
  end


end
