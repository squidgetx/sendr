class Climber < ActiveRecord::Base
  belongs_to :college
  has_many :climbs
  has_many :routes, through: :climbs
  has_many :comps, through: :scoresheets
  has_many :scoresheets
end
