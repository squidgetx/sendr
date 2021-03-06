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
  LEADERCOUNT = 3

  scope :boulder_leaders, -> { order(boulder_score: :desc).limit(LEADERCOUNT) }
  scope :sport_leaders, -> { order(sport_score: :desc).limit(LEADERCOUNT) }
  scope :speed_leaders, -> { order(speed: :asc).limit(LEADERCOUNT) }

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
    Route.joins("LEFT JOIN climbs on routes.id = climbs.route_id AND climbs.scoresheet_id = #{self.id} AND routes.comp_id = #{self.comp.id}").select("routes.*, climbs.attempts AS attempts, climbs.sent AS sent, climbs.witness AS witness")
      .order('routes.points asc')
  end

  def update_scores
    sent = Route.joins(:climbs).where("climbs.scoresheet_id = ? AND climbs.sent = TRUE", self.id)
    sport = sent.sport.collect(&:points).sum
    boulder = sent.boulder.collect(&:points).sum
    self.sport_score = sport
    self.boulder_score = boulder
    self.save
  end

end
