class Route < ActiveRecord::Base
  belongs_to :comp
  has_many :climbs
  has_many :climbers, through: :climbs

  validates :points, presence: true

  enum discipline: [ :sport,  :boulder]


end
