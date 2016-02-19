class Scoresheet < ActiveRecord::Base
  has_many :climbs
  belongs_to :comp
  belongs_to :climber
  has_many :routes, through: :climbs

  after_initialize :init

  validates :climber_id, presence: true
  validates :comp_id, presence: true
  validates :boulder_score, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :sport_score, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  BOULDERCOUNT = 5
  SPORTCOUNT = 3

  def init
    self.boulder_score ||= 0
    self.sport_score ||= 0
  end

  def record_speed time
    time = time.to_f
    if time == 0
      return false
    end
    if self.speed_attempt1.nil?
      self.speed_attempt1 = time
      self.speed = time
    elsif self.speed_attempt2.nil?
      self.speed_attempt2 = time
      if time < self.best_speed
        self.speed = time
      end
    else
      return false
    end
    self.save
  end

  def get_climbs
    climbs = Route.joins("LEFT JOIN climbs on routes.id = climbs.route_id AND climbs.scoresheet_id = #{self.id} AND routes.comp_id = #{self.comp.id}").select("routes.*, climbs.attempts AS attempts, climbs.sent AS sent, climbs.witness AS witness")
      .order('routes.points asc')
  end

  def update_scores
    sport = self.climbs.includes(:route).where(routes: {discipline: "sport"}, climbs: {sent: true}).order("routes.points desc").limit(SPORTCOUNT).select("routes.points").sum
    boulder = self.climbs.includes(:route).where(routes: {discipline: "boulder"}, climbs: {sent: true}).order("routes.points desc").limit(BOULDERCOUNT).select("routes.points").sum
    self.sport_score = sport
    self.boulder_score = boulder
  end

end
