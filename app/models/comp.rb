class Comp < ActiveRecord::Base
  has_many :routes
  has_many :scoresheets
  has_many :climbers, through: :scoresheets

  validates :location, presence: true
  validates :date, presence: true
  validates :state, presence: true

  def join(climber_id)
    # Currently logged in climber
    # joins comp and creates new scoresheet
    return nil if climber_id.nil?
    sc = Scoresheet.where({climber_id: climber_id, comp_id: self.id}).first
    return sc if sc.present?
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

  def closed
    self.state == 'closed'
  end

  def leaders
    # Get the leaders!
    scoresheets = self.scoresheets.joins(climber: :college).select("scoresheets.*, climbers.*, colleges.name AS college_name")
    boulders = scoresheets.order(boulder_score: :desc).limit(3)
    sport = scoresheets.order(sport_score: :desc).limit(3)
    speed = scoresheets.order(speed: :asc).limit(3)
    results = {
      boulder: boulders,
      sport: sport,
      speed: speed
    }
    results
  end
end

