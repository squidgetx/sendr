class Climber < ActiveRecord::Base
  belongs_to :college
  has_many :climbs
  has_many :routes, through: :climbs
end
