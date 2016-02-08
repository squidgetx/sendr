class Comp < ActiveRecord::Base
  has_many :routes
  has_many :scoresheets
  has_many :climbers, through: :scoresheets

  def join(climber_id)
    # Currently logged in climber
    # joins comp and creates new scoresheet
    return nil if climber_id.nil?
    return Scoresheet.create({
      comp_id: self.id,
      climber_id: climber_id,
      boulder_score: 0,
      sport_score: 0,
    })
  end

  def self.open
    # Get open comps
    Comp.where("state = 'open'")
  end
end
