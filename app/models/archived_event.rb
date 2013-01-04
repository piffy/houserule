class ArchivedEvent < ActiveRecord::Base
  attr_accessible :begins_at, :deadline, :descr_short, :description, :duration,
                  :location, :max_player_num, :min_player_num, :name, :system, :aftermath,
                  :user_id, :subscriber_list

  belongs_to :user
  validates_length_of :descr_short, :maximum=>255
  validates :max_player_num, :numericality => { :greater_than_or_equal_to => :min_player_num }
  validates :min_player_num, :numericality => { :greater_than_or_equal_to => 0 }
  validates_date_of :begins_at, :allow_nil => true
  validates_date_of :deadline, :allow_nil => true
  validates :deadline, :date => {:before_or_equal_to => :begins_at }, :allow_nil => true
  validates_presence_of :user_id, :message => "deve avere un utente"
  validates_presence_of :name, :message => "non deve essere vuoto"

  def status
    4
  end

end
