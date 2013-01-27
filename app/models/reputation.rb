class Reputation < ActiveRecord::Base
  attr_accessible :negative_fb,
                  :participations, :positive_fb, :user_id,
                  :organized, :archived

  validates :negative_fb, :participations, :positive_fb,
            :organized, :archived,
            :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }

  belongs_to :user;
  validates_presence_of :user_id, :message => "deve avere un utente"

  def score
    (positive_fb-negative_fb+Math.log(user.groups.count+1,2)+Math.log(user.interests.count+1,2)+
        Math.log(participations+1,2) + Math.log(archived+1,2)  + Math.log(organized+1,2)).to_i
  end

  def score_to_s
    case score
      when -60000..-5 then "Demogorgon"
      when -4..-1 then "Demone"
      when 0..4 then "Goblin"
      when 5..12 then "Umano"
      when 13..20 then "Angelo"
      else "Dio"
    end
  end

  def user_name
    self.user.first_name_or_nick
    #User.find(user_id).first_name_or_nick
  end
end
