class Climb < ActiveRecord::Base
  belongs_to :scoresheet
  belongs_to :route
  after_initialize :init

  def attempt
    self.attempts += 1
  end

  def send
    self.send = true
  end

  def init
    self.attempts = 0
    self.sent = false
    self.witness = ""
  end


end
