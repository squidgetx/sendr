class Climber < ActiveRecord::Base
  belongs_to :college
  has_many :climbs, through: :scoresheets
  has_many :comps, through: :scoresheets
  has_many :scoresheets
end
