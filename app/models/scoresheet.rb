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
  end

end
