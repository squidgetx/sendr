class Route < ActiveRecord::Base
  belongs_to :comp
  has_many :climbs
  has_many :climbers, through: :climbs

  def attempt
    # current climber attempts route
    climb = Climb.where("climber_id = ? AND route_id = ?", current_climber.id, self.id)
    return nil if climb.nil?
    climb.attempt
  end

end
