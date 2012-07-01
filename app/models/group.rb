class Group < ActiveRecord::Base
  attr_accessible :description, :image_url, :location, :name, :user_id, :website_url
  validates :name, presence: true, :uniqueness => { case_sensitive: false }

  valid_url_regex_or_empty = /^$|(^((http|https|ftp):\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]*)+.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :image_url,  :format     => { with: valid_url_regex_or_empty }
  validates :website_url,:format     => { with: valid_url_regex_or_empty }
end
