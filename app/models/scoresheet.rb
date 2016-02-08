class Scoresheet < ActiveRecord::Base
  has_many :climbs
  belongs_to :comp
  belongs_to :climber
end
