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
    elsif self.speed_attempt2.nil?
      self.speed_attempt2 = time
    else
      return false
    end
    self.save
  end

  def best_speed
    if self.speed_attempt1.nil?
      return nil
    end

    if self.speed_attempt2.nil?
      return self.speed_attempt1
    end
    
    return [self.speed_attempt1, self.speed_attempt2].min

  end


  def get_climbs
    climbs = self.comp.routes.left_join(:climbs)
      .where("climbs.scoresheet_id = ? OR routes.comp_id = ?", self.id, self.comp.id)
      .select("routes.*, climbs.attempts AS attempts, climbs.witness AS witness, climbs.sent AS sent")
      .order('routes.points asc')

   # routes = self.comp.routes
   # climbs = climbs.merge(routes)
   # climbs
  end

end
