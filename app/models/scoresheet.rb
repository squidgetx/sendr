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

  def init
    self.boulder_score = 0
    self.sport_score = 0
    self.speed_attempts = 0
  end

  def record_speed time
    return nil if self.speed_attempts == 2
    if (self.speed > time)
      self.speed = time
    end
    self.speed_attempts += 1
    self.save
  end

  def get_climbs
    self.comp.routes.left_join(:climbs)
      .where("climbs.scoresheet_id = ?", self.id)
      .select("routes.*, climbs.attempts AS attempts, climbs.witness AS witness, climbs.sent AS sent")
      .order('routes.points asc')
  end

end
