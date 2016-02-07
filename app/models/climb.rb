class Climb < ActiveRecord::Base
  belongs_to :climber
  belongs_to :route
end
