class Comp < ActiveRecord::Base
  has_many :routes
  has_many :scoresheets
  has_many :climbers, through: :scoresheets

  validates :location, presence: true
  validates :date, presence: true
  validates :state, presence: true

  enum state: [:closed, :open, :running]

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

  def leaders
    # Get the leaders!
    males = self.scoresheets.joins(climber: :college).where(climbers: {gender: 0}).select("scoresheets.*, climbers.*, colleges.name AS college_name")
    females = self.scoresheets.joins(climber: :college).where(climbers: {gender: 1}).select("scoresheets.*, climbers.*, colleges.name AS college_name")
    results = {
      males: {
        boulder: males.boulder_leaders,
        sport: males.sport_leaders,
        speed: males.speed_leaders
      },
      females: {
        boulder: females.boulder_leaders,
        sport: females.sport_leaders,
        speed: females.speed_leaders
      }
    }
    results
  end
end

