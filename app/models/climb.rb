class Climb < ActiveRecord::Base
  belongs_to :scoresheet
  belongs_to :route

  def attempt
    self.attempts += 1
  end

  def send
    self.send = true
  end


end